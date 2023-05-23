import { HasValue, runQuery } from "@latticexyz/recs";
import EntityLayer from "./EntityLayer";
import GoldSpawnLayer from "./GoldSpawnLayer";
import ItemSpawnLayer from "./ItemSpawnLayer";
import { useMUD } from "./MUDContext";
import {
  getGoldSeedsAtPosition,
  getItemSeedsAtPosition,
} from "./utils/itemSpawn";

export type TileProps = {
  x: number;
  y: number;
};

export default function Tile({ x, y }: TileProps) {
  const {
    components: { Position },
  } = useMUD();

  const goldSeeds = getGoldSeedsAtPosition(x, y);
  const itemSeeds = getItemSeedsAtPosition(x, y);

  const matchingEntities = runQuery([
    HasValue(Position, { x: BigInt(x), y: BigInt(y) }),
  ]);

  return (
    <div
      style={{
        width: 30,
        height: 30,
        fontSize: 24,
        color: "white",
        display: "flex",
        alignItems: "center",
        justifyContent: "center",
      }}
    >
      {Array.from(matchingEntities).map((entity) => (
        <EntityLayer key={entity} entity={entity} />
      ))}
      {goldSeeds.map((seed) => (
        <GoldSpawnLayer key={seed.toString()} x={x} y={y} seed={seed} />
      ))}
      {itemSeeds.map((seed) => (
        <ItemSpawnLayer key={seed.toString()} x={x} y={y} seed={seed} />
      ))}
      <span style={{ color: "#222", fontSize: 24 }}>·</span>
    </div>
  );
}
