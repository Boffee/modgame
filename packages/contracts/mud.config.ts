import { mudConfig, resolveTableId } from "@latticexyz/world/register";

export default mudConfig({
  systems: {
    MoveSubSystem: {
      openAccess: false,
      accessList: [],
    },
    AttackSubSystem: {
      openAccess: false,
      accessList: [],
    },
  },
  tables: {
    Token: "bytes32",
    Id: "uint256",
    Type: "bytes32",
    Orientation: "OrientationType",
    MoveStat: {
      schema: {
        maxDistance: "uint32",
        cooldown: "uint32",
      },
    },
    Hook: {
      keySchema: {
        entityType: "bytes32",
        hookType: "bytes32",
      },
      schema: {
        selector: "bytes4",
      },
    },
    AttackStat: {
      schema: {
        maxDistance: "uint32",
        cooldown: "uint32",
      },
    },
    Mutation: {
      schema: {
        entityType: "bytes32",
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
  enums: {
    PositionLevel: ["Underground", "Surface"],
    OrientationType: ["North", "East", "South", "West"],
  },
  modules: [
    {
      name: "KeysWithValueModule",
      root: true,
      args: [resolveTableId("Position")],
    },
  ],
});
