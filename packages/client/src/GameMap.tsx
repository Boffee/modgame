import _ from "lodash";
import Tile from "./Tile";

export type GameMapProps = {
  centerX: number;
  centerY: number;
  rows: number;
  cols: number;
};
export default function GameMap({
  centerX,
  centerY,
  rows,
  cols,
}: GameMapProps) {
  const xRange = _.range(
    Math.round(centerX - rows / 2),
    Math.round(centerX + rows / 2)
  );
  const yRange = _.range(
    Math.round(centerY - cols / 2),
    Math.round(centerY + cols / 2)
  );
  return (
    <div>
      {yRange.map((y) => (
        // horizontal rows
        <div
          key={y}
          style={{
            backgroundColor: "#111",
            display: "flex",
            flexDirection: "row",
          }}
        >
          {xRange.map((x) => (
            <Tile key={x} x={x} y={y} />
          ))}
        </div>
      ))}
    </div>
  );
}
