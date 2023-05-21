import { mudConfig } from "@latticexyz/world/register";

export default mudConfig({
  tables: {
    Id: "uint256",
    Counter: "uint256",
    Creature: "bytes32",
    CreatureLineage: "bytes32",
    CreatureStats: {
      schema: {
        lifespan: "uint40",
        moveDistance: "uint8",
        moveCooldown: "uint40",
        attackDistance: "uint8",
        attackCooldown: "uint40",
        cooldownReserveCapacity: "uint40",
      },
    },
    Mutation: {
      schema: {
        creature: "bytes32",
        endsAt: "uint40",
      },
    },
    Diet: {
      keySchema: {
        creature: "bytes32",
        resource: "bytes32",
      },
      schema: "bool",
    },
    Drop: {
      keySchema: {
        creature: "bytes32",
      },
      schema: {
        primaryResource: "bytes32",
        secondaryResource: "bytes32",
        primaryResourceQuantity: "uint128",
        secondaryResourceQuantity: "uint128",
      },
    },
    Predation: {
      keySchema: {
        predator: "bytes32",
        prey: "bytes32",
      },
      schema: "bool",
    },
    Position: {
      schema: {
        x: "int128",
        y: "int128",
      },
    },
    Balance: {
      keySchema: {
        token: "bytes32",
        owner: "bytes32",
      },
      schema: "uint256",
    },
    TotalSupply: "uint256",
    Owner: "address",
    Metdata: {
      schema: {
        createdAt: "uint40",
        updatedAt: "uint40",
      },
    },
    Cooldown: {
      schema: {
        readyAt: "uint40",
        reserve: "uint40",
      },
    },
  },
});
