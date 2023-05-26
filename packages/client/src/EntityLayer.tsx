import { useComponentValue } from "@latticexyz/react";
import { Entity } from "@latticexyz/recs";
import { useMUD } from "./MUDContext";

export type EntityLayerProps = {
  entity: Entity;
};

export default function EntityLayer({ entity }: EntityLayerProps) {
  const {
    components: { ImageUri, Type, Orientation },
  } = useMUD();

  const type = useComponentValue(Type, entity);
  const uri = useComponentValue(ImageUri, type?.value as Entity);
  const orientation = useComponentValue(Orientation, entity);
  const rotateAngle = (orientation?.value || 0) * 90;

  return (
    <div className={`absolute rotate-[${rotateAngle}deg]`}>
      {uri?.value || "?"}
    </div>
  );
}
