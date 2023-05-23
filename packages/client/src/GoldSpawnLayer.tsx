import { useComponentValue } from "@latticexyz/react";
import { Entity } from "@latticexyz/recs";
import { BigNumberish } from "ethers";
import { useMUD } from "./MUDContext";
import TypeLayer from "./TypeLayer";
import { GOLD_TOKEN } from "./constants";
import { getGoldKey } from "./utils/itemSpawn";

export type GoldSpawnLayerProps = {
  x: number;
  y: number;
  seed: BigNumberish;
};

export default function GoldSpawnLayer({ x, y, seed }: GoldSpawnLayerProps) {
  const {
    components: { Collected },
  } = useMUD();

  const collected = useComponentValue(
    Collected,
    getGoldKey(seed) as Entity
  )?.value;

  if (collected) return <></>;

  return <TypeLayer type={GOLD_TOKEN as Entity} />;
}
