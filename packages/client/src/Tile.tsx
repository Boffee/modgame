import { HasValue, runQuery } from "@latticexyz/recs";
import { HTMLAttributes } from "react";
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
} & HTMLAttributes<HTMLDivElement>;

export default function Tile({ x, y, ...passProps }: TileProps) {
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
      className="w-8 h-8 text-2xl flex items-center justify-center"
      {...passProps}
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
    </div>
  );
}
