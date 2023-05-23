import { useComponentValue } from "@latticexyz/react";
import { useEffect } from "react";
import GameMap from "./GameMap";
import { useMUD } from "./MUDContext";
import { useKeyboardMovement } from "./hooks/useKeyboardMovement";

export type GameBoardProps = {
  rows: number;
  cols: number;
};
export default function GameBoard({ rows, cols }: GameBoardProps) {
  useKeyboardMovement();

  const {
    components: { Position, Owner },
    systemCalls: { spawn },
    network: { playerEntity },
  } = useMUD();

  const owner = useComponentValue(Owner, playerEntity)?.value;
  const position = useComponentValue(Position, playerEntity);

  useEffect(() => {
    if (!owner) {
      spawn();
    }
  }, [owner]);

  return (
    <GameMap
      centerX={Number(position?.x || 0)}
      centerY={Number(position?.y || 0)}
      rows={rows}
      cols={cols}
    />
  );
}
