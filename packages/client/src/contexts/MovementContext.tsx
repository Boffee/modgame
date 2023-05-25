import {
  HTMLAttributes,
  PropsWithChildren,
  createContext,
  useContext,
  useEffect,
  useRef,
} from "react";
import { useMUD } from "../MUDContext";

export type MovementPosition = { x: bigint; y: bigint; timestamp: number };
export type Movement = MovementPosition[];
export type Movements = Record<string, Movement>;

export type MovementContextProps = {
  movements?: Movements;
};

export type MovementContextProviderProps = PropsWithChildren<
  HTMLAttributes<HTMLDivElement>
>;

export const MovementContext = createContext<MovementContextProps>({});

export function MovementContextProvider({
  children,
}: MovementContextProviderProps) {
  const movementsRef = useRef<Movements>({});
  const {
    network: { storeCache },
  } = useMUD();

  useEffect(() => {
    if (!storeCache) return;

    storeCache.tables.Position.subscribe((data) => {
      const timestamp = Date.now();
      const movements = movementsRef.current;
      data.forEach(({ set }) =>
        set.forEach(({ key, value: { x, y } }) => {
          if (movements[key.key]) {
            movements[key.key].push({ x, y, timestamp });
          } else {
            movements[key.key] = [{ x, y, timestamp }];
          }
        })
      );
    });
  }, [storeCache]);

  return (
    <MovementContext.Provider value={{ movements: movementsRef.current }}>
      {children}
    </MovementContext.Provider>
  );
}

export function useMovement(entity: string) {
  const { movements } = useContext(MovementContext);
  return movements?.[entity];
}

export function useMovements() {
  const { movements } = useContext(MovementContext);
  return movements;
}
