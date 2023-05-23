import { useComponentValue } from "@latticexyz/react";
import { Entity } from "@latticexyz/recs";
import { useMUD } from "./MUDContext";

export type TypeLayerProps = {
  type: Entity;
};

export default function TypeLayer({ type }: TypeLayerProps) {
  const {
    components: { ImageUri },
  } = useMUD();

  const uri = useComponentValue(ImageUri, type)?.value;

  return <>{uri || "🪨"}</>;
}
