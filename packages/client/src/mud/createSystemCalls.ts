import { awaitStreamValue } from "@latticexyz/utils";
import { BytesLike } from "ethers";
import { SetupNetworkResult } from "./setupNetwork";

export type SystemCalls = ReturnType<typeof createSystemCalls>;

export function createSystemCalls({
  worldSend,
  txReduced$,
  singletonEntity,
}: SetupNetworkResult) {
  const spawn = async () => {
    const tx = await worldSend("spawn", []);
    await awaitStreamValue(txReduced$, (txHash) => txHash === tx.hash);
  };

  const move = async (entity: BytesLike, x: number, y: number) => {
    const tx = await worldSend("move", [entity, x, y]);
    await awaitStreamValue(txReduced$, (txHash) => txHash === tx.hash);
  };

  return {
    spawn,
    move,
  };
}
