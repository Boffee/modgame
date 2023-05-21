import { mudConfig } from "@latticexyz/world/register";

export default mudConfig({
  tables: {
    Id: {
      schema: "uint256",
    },
    Counter: {
      schema: "uint256",
    },
    Creature: {
      schema: "bytes32",
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
        predatorType: "bytes32",
        preyType: "bytes32",
      },
      schema: "bool",
    },
    Position: {
      schema: {
        x: "uint128",
        y: "uint128",
      },
    },
    Mutation: {
      schema: {
        parent: "bytes32",
      },
    },
    Balance: {
      keySchema: {
        token: "bytes32",
        owner: "bytes32",
      },
      schema: "uint256",
    },
    Owner: {
      schema: "address",
    },
    Metdata: {
      schema: {
        createdAt: "uint40",
        updatedAt: "uint40",
      },
    },
  },
});
