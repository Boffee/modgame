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
  const xStart = Math.round(centerX - rows / 2);
  const yStart = Math.round(centerY - cols / 2);
  const xEnd = Math.round(centerX + rows / 2);
  const yEnd = Math.round(centerY + cols / 2);

  const yRange = _.range(yStart, yEnd);
  const xRange = _.range(xStart, xEnd);

  return (
    <div
      style={{
        position: "relative",
        backgroundSize: "2rem 2rem",
        backgroundImage:
          "radial-gradient(circle, rgba(256,256,256,0.375) 0.1rem, rgba(0, 0, 0, 0) 0.1rem)",
      }}
    >
      {yRange.map((y) => (
        // horizontal rows
        <div key={y} className="flex flex-row">
          {xRange.map((x) => (
            <Tile key={x} x={x} y={y} />
          ))}
        </div>
      ))}
    </div>
  );
}
