import { ethers } from "ethers";

export function toBytes32(address: string) {
  return ethers.utils.hexZeroPad(address, 32);
}
