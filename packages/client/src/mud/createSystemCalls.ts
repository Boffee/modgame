import { awaitStreamValue } from "@latticexyz/utils";
import { BigNumberish, BytesLike } from "ethers";
import { BLUE, GREEN, RED } from "../constants";
import { SetupNetworkResult } from "./setupNetwork";

export type SystemCalls = ReturnType<typeof createSystemCalls>;

export function createSystemCalls({
  worldSend,
  txReduced$,
}: SetupNetworkResult) {
  const spawn = async () => {
    const seed = Math.floor(Date.now() / 1000);
    const type = [RED, GREEN, BLUE][seed % 3];
    // sample x and y between -8 and 8
    const x = Math.floor(Math.random() * 16) - 8;
    const y = Math.floor(Math.random() * 16) - 8;

    const tx = await worldSend("spawn", [type, x, y]);
    await awaitStreamValue(txReduced$, (txHash) => txHash === tx.hash);
  };

  const move = async (
    entity: BytesLike,
    x: BigNumberish,
    y: BigNumberish,
    goldBlockNumbers: BigNumberish[],
    itemBlockNumbers: BigNumberish[]
  ) => {
    const tx = await worldSend("move", [
      entity,
      x,
      y,
      goldBlockNumbers,
      itemBlockNumbers,
    ]);
    await awaitStreamValue(txReduced$, (txHash) => txHash === tx.hash);
  };

  const moveRelative = async (
    entity: BytesLike,
    dx: BigNumberish,
    dy: BigNumberish,
    goldBlockNumbers: BigNumberish[],
    itemBlockNumbers: BigNumberish[]
  ) => {
    const tx = await worldSend("moveRelative", [
      entity,
      dx,
      dy,
      goldBlockNumbers,
      itemBlockNumbers,
    ]);
    await awaitStreamValue(txReduced$, (txHash) => txHash === tx.hash);
  };

  const trigger = async (entity: BytesLike, target: BytesLike) => {
    const tx = await worldSend("trigger", [entity, target]);
    await awaitStreamValue(txReduced$, (txHash) => txHash === tx.hash);
  };

  const attack = async (entity: BytesLike, target: BytesLike) => {
    const tx = await worldSend("attack", [entity, target]);
    await awaitStreamValue(txReduced$, (txHash) => txHash === tx.hash);
  };

  return {
    attack,
    move,
    moveRelative,
    spawn,
    trigger,
  };
}
