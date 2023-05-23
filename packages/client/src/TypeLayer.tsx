import { useComponentValue } from "@latticexyz/react";
import { Entity } from "@latticexyz/recs";
import { useMUD } from "./MUDContext";

export type TypeLayerProps = {
  type: Entity;
  inactive?: boolean;
};

export default function TypeLayer({ type, inactive }: TypeLayerProps) {
  const {
    components: { ImageUri },
  } = useMUD();

  const uri = useComponentValue(ImageUri, type)?.value;

  return (
    <div
      style={{
        position: "absolute",
        opacity: inactive ? "30%" : "100%",
      }}
    >
      {uri || "?"}
    </div>
  );
}
