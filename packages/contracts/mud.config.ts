import { mudConfig } from "@latticexyz/world/register";

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
    AttributesSubSystem: {
      openAccess: false,
      accessList: [],
    },
    TriggerSubSystem: {
      openAccess: false,
      accessList: [],
    },
    // TODO: deploy in a separate namespace to enforce access control
    HookHandlerProxySubSystem: {
      openAccess: false,
      accessList: [],
    },
  },
  excludeSystems: [
    "AuthedSystem",
    "CooldownSystem",
    "MutableSystem",
    "EntityHookSystem",
  ],
  tables: {
    // TODO: optimize for gas
    Token: "bytes32",
    Id: "uint256",
    Type: "bytes32",
    Name: "string",
    Description: "string",
    ImageUri: "string",
    Immutable: "bool",
    Collected: "bool",
    ModList: {
      keySchema: {},
      schema: "bytes32[]",
    },
    Orientation: "OrientationType",
    MoveStat: {
      schema: {
        maxDistance: "uint32",
        cooldown: "uint32",
      },
    },
    AttackStat: {
      schema: {
        maxDistance: "uint32",
        cooldown: "uint32",
      },
    },
    HookHandlerRegistry: "address",
    HookHandler: {
      keySchema: {
        entityType: "bytes32",
        hookType: "bytes32",
      },
      schema: "address",
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
    AtPosition: {
      keySchema: {
        x: "int128",
        y: "int128",
      },
      schema: "bytes32[]",
    },
    Balance: {
      keySchema: {
        token: "bytes32",
        owner: "bytes32",
      },
      schema: "uint256",
    },
    TotalSupply: "uint256",
    Owner: "bytes32",
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
    DirectionType: ["Forward", "Right", "Backward", "Left"],
  },
  modules: [
    {
      name: "UniqueEntityModule",
      root: true,
      args: [],
    },
  ],
});
