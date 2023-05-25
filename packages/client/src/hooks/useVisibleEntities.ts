import { useRows } from "@latticexyz/react";
import { useMUD } from "../MUDContext";

export type useVisibleEntitiesProps = {
  xStart: number;
  xEnd: number;
  yStart: number;
  yEnd: number;
};

export default function useVisibleEntities({
  xStart,
  xEnd,
  yStart,
  yEnd,
}: useVisibleEntitiesProps) {
  const {
    network: { storeCache },
  } = useMUD();

  const atPositionsFiltered = useRows(storeCache, {
    table: "AtPosition",
    key: {
      gte: { x: BigInt(xStart), y: BigInt(yStart) },
      lt: { x: BigInt(xEnd), y: BigInt(yEnd) },
    },
  });

  return atPositionsFiltered.flatMap(({ value }) => value.value);
}
