import { useComponentValue } from "@latticexyz/react";
import { Entity } from "@latticexyz/recs";
import { useMUD } from "./MUDContext";

export type EntityLayerProps = {
  entity: Entity;
};

export default function EntityLayer({ entity }: EntityLayerProps) {
  const {
    components: { ImageUri, Type },
  } = useMUD();

  const type = useComponentValue(Type, entity);
  const uri = useComponentValue(ImageUri, type?.value as Entity);

  return (
    <div
      style={{
        position: "absolute",
      }}
    >
      {uri?.value || "?"}
    </div>
  );
}
