import { mudConfig } from "@latticexyz/world/register";

export default mudConfig({
  tables: {
    Id: "uint256",
    Counter: "uint256",
    CreatureType: "bytes32",
    CreatureTypeLineage: "bytes32",
    CreatureTypeStats: {
      schema: {
        lifespan: "uint40",
        moveDistance: "uint8",
        moveCooldown: "uint40",
        attackDistance: "uint8",
        attackCooldown: "uint40",
        cooldownReserveCapacity: "uint40",
      },
    },
    CreatureMutation: {
      schema: {
        creature: "bytes32",
        endsAt: "uint40",
      },
    },
    Predation: {
      keySchema: {
        predatorType: "bytes32",
        preyType: "bytes32",
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
        endsAt: "uint40",
        reserve: "uint40",
      },
    },
    MoveCommitment: "bytes32",
  },
});
