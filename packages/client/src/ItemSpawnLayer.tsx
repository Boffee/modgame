import { useComponentValue } from "@latticexyz/react";
import { Entity } from "@latticexyz/recs";
import { BigNumberish } from "ethers";
import { useMUD } from "./MUDContext";
import TypeLayer from "./TypeLayer";
import { getItemIndex, getItemKey } from "./utils/itemSpawn";

export type ItemSpawnLayerProps = {
  x: number;
  y: number;
  seed: BigNumberish;
};

export default function ItemSpawnLayer({ x, y, seed }: ItemSpawnLayerProps) {
  const {
    components: { ImageUri, Collected, ModList },
    network: { singletonEntity },
  } = useMUD();

  const collected = useComponentValue(
    Collected,
    getItemKey(seed) as Entity
  )?.value;
  const modList = useComponentValue(ModList, singletonEntity)?.value;

  if (collected || !modList?.length) return <></>;

  const itemType = modList[getItemIndex(seed, modList.length)];

  return <TypeLayer type={itemType as Entity} />;
}
