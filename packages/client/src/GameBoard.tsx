import { useComponentValue } from "@latticexyz/react";
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
    components: { Position },
    network: { playerEntity },
  } = useMUD();

  const position = useComponentValue(Position, playerEntity);

  return (
    <GameMap
      centerX={Number(position?.x || 0)}
      centerY={Number(position?.y || 0)}
      rows={rows}
      cols={cols}
    />
  );
}
