import { getComponentValue } from "@latticexyz/recs";
import _ from "lodash";
import { useEffect } from "react";
import { useMUD } from "../MUDContext";
import {
  getGoldSeedsAtPosition,
  getItemSeedsAtPosition,
} from "../utils/itemSpawn";
import { toBytes32 } from "../utils/typeCast";

export const useKeyboardMovement = () => {
  const {
    components: { Position },
    systemCalls: { move, attack, trigger },
    network: { playerEntity },
  } = useMUD();

  useEffect(() => {
    const listener = (e: KeyboardEvent) => {
      if (!playerEntity) return;
      const position = getComponentValue(Position, playerEntity);

      let x = Number(position?.x || 0);
      let y = Number(position?.y || 0);
      if (e.key === "ArrowUp") {
        y -= 1;
      }
      if (e.key === "ArrowDown") {
        y += 1;
      }
      if (e.key === "ArrowLeft") {
        x -= 1;
      }
      if (e.key === "ArrowRight") {
        x += 1;
      }
      const goldSeeds = getGoldSeedsAtPosition(x, y);
      const itemSeeds = getItemSeedsAtPosition(x, y);
      move(toBytes32(playerEntity), x, y, goldSeeds, itemSeeds);
    };

    const listenerThrottled = _.throttle(listener, 500);

    window.addEventListener("keydown", listenerThrottled);
    return () => window.removeEventListener("keydown", listenerThrottled);
  }, [move, playerEntity]);
};
