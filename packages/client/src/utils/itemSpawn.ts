import { BigNumber, BigNumberish, ethers } from "ethers";
import { GOLD_TOKEN, ITEM_TOKEN } from "../constants";
import { unixTime } from "./time";

export function getItemIndex(seed: BigNumberish, itemCount: number) {
  return BigNumber.from(random(seed))
    .mod(itemCount || 1)
    .toNumber();
}

export function getPosition(seed: BigNumberish) {
  const x = BigNumber.from(random(seed)).mod(1000).sub(500).toNumber();
  const y = BigNumber.from(random(seed))
    .div(1000)
    .mod(1000)
    .sub(500)
    .toNumber();
  const key = `${x},${y}`;
  if (cache[key]) {
    cache[key].push(seed);
  } else {
    cache[key] = [seed];
  }
  return { x, y };
}

export function random(seed: BigNumberish): string {
  return ethers.utils.solidityKeccak256(
    ["bytes32"],
    [ethers.utils.solidityPack(["uint256"], [seed])]
  );
}

const cache: Record<string, BigNumberish[]> = {};

export const SPAWN_AMOUNT = 10000;

const startTime = unixTime() - SPAWN_AMOUNT * 2;

setTimeout(() => {
  for (let i = 0; i < SPAWN_AMOUNT * 2; i++) {
    getPosition(startTime + i);
  }
}, 1);

setInterval(() => {
  const time = unixTime();
  getPosition(time);
}, 1000);

function getSeedsAtPosition(x: number, y: number, start: number, end: number) {
  const key = `${x},${y}`;
  return (
    cache[key]?.filter(
      (seed) => BigNumber.from(seed).gte(start) && BigNumber.from(seed).lte(end)
    ) || []
  );
}

export function getItemSeedsAtPosition(x: number, y: number) {
  const time = unixTime();
  return getSeedsAtPosition(x, y, time - SPAWN_AMOUNT, time);
}

export function getGoldSeedsAtPosition(x: number, y: number) {
  const time = unixTime();
  return getSeedsAtPosition(x, y, time - SPAWN_AMOUNT * 2, time - SPAWN_AMOUNT);
}

export function getGoldKey(seed: BigNumberish) {
  return ethers.utils.solidityKeccak256(
    ["bytes"],
    [
      ethers.utils.defaultAbiCoder.encode(
        ["bytes32", "uint256"],
        [GOLD_TOKEN, seed]
      ),
    ]
  );
}

export function getItemKey(seed: BigNumberish) {
  return ethers.utils.solidityKeccak256(
    ["bytes"],
    [
      ethers.utils.defaultAbiCoder.encode(
        ["bytes32", "uint256"],
        [ITEM_TOKEN, seed]
      ),
    ]
  );
}
