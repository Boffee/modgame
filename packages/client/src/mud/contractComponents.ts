/* Autogenerated file. Do not edit manually. */

import { TableId } from "@latticexyz/utils";
import { defineComponent, Type as RecsType, World } from "@latticexyz/recs";

export function defineContractComponents(world: World) {
  return {
    Token: (() => {
      const tableId = new TableId("", "Token");
      return defineComponent(
        world,
        {
          value: RecsType.String,
        },
        {
          metadata: {
            contractId: tableId.toHexString(),
            tableId: tableId.toString(),
          },
        }
      );
    })(),
    Id: (() => {
      const tableId = new TableId("", "Id");
      return defineComponent(
        world,
        {
          value: RecsType.BigInt,
        },
        {
          metadata: {
            contractId: tableId.toHexString(),
            tableId: tableId.toString(),
          },
        }
      );
    })(),
    Type: (() => {
      const tableId = new TableId("", "Type");
      return defineComponent(
        world,
        {
          value: RecsType.String,
        },
        {
          metadata: {
            contractId: tableId.toHexString(),
            tableId: tableId.toString(),
          },
        }
      );
    })(),
    MoveStat: (() => {
      const tableId = new TableId("", "MoveStat");
      return defineComponent(
        world,
        {
          maxDistance: RecsType.Number,
          cooldown: RecsType.Number,
        },
        {
          metadata: {
            contractId: tableId.toHexString(),
            tableId: tableId.toString(),
          },
        }
      );
    })(),
    Hook: (() => {
      const tableId = new TableId("", "Hook");
      return defineComponent(
        world,
        {
          selector: RecsType.String,
        },
        {
          metadata: {
            contractId: tableId.toHexString(),
            tableId: tableId.toString(),
          },
        }
      );
    })(),
    AttackStat: (() => {
      const tableId = new TableId("", "AttackStat");
      return defineComponent(
        world,
        {
          maxDistance: RecsType.Number,
          cooldown: RecsType.Number,
        },
        {
          metadata: {
            contractId: tableId.toHexString(),
            tableId: tableId.toString(),
          },
        }
      );
    })(),
    Mutation: (() => {
      const tableId = new TableId("", "Mutation");
      return defineComponent(
        world,
        {
          entityType: RecsType.String,
          endsAt: RecsType.Number,
        },
        {
          metadata: {
            contractId: tableId.toHexString(),
            tableId: tableId.toString(),
          },
        }
      );
    })(),
    Predation: (() => {
      const tableId = new TableId("", "Predation");
      return defineComponent(
        world,
        {
          value: RecsType.Boolean,
        },
        {
          metadata: {
            contractId: tableId.toHexString(),
            tableId: tableId.toString(),
          },
        }
      );
    })(),
    Position: (() => {
      const tableId = new TableId("", "Position");
      return defineComponent(
        world,
        {
          x: RecsType.BigInt,
          y: RecsType.BigInt,
        },
        {
          metadata: {
            contractId: tableId.toHexString(),
            tableId: tableId.toString(),
          },
        }
      );
    })(),
    Balance: (() => {
      const tableId = new TableId("", "Balance");
      return defineComponent(
        world,
        {
          value: RecsType.BigInt,
        },
        {
          metadata: {
            contractId: tableId.toHexString(),
            tableId: tableId.toString(),
          },
        }
      );
    })(),
    TotalSupply: (() => {
      const tableId = new TableId("", "TotalSupply");
      return defineComponent(
        world,
        {
          value: RecsType.BigInt,
        },
        {
          metadata: {
            contractId: tableId.toHexString(),
            tableId: tableId.toString(),
          },
        }
      );
    })(),
    Owner: (() => {
      const tableId = new TableId("", "Owner");
      return defineComponent(
        world,
        {
          value: RecsType.String,
        },
        {
          metadata: {
            contractId: tableId.toHexString(),
            tableId: tableId.toString(),
          },
        }
      );
    })(),
    Metdata: (() => {
      const tableId = new TableId("", "Metdata");
      return defineComponent(
        world,
        {
          createdAt: RecsType.Number,
          updatedAt: RecsType.Number,
        },
        {
          metadata: {
            contractId: tableId.toHexString(),
            tableId: tableId.toString(),
          },
        }
      );
    })(),
    Cooldown: (() => {
      const tableId = new TableId("", "Cooldown");
      return defineComponent(
        world,
        {
          endsAt: RecsType.Number,
          reserve: RecsType.Number,
        },
        {
          metadata: {
            contractId: tableId.toHexString(),
            tableId: tableId.toString(),
          },
        }
      );
    })(),
    MoveCommitment: (() => {
      const tableId = new TableId("", "MoveCommitment");
      return defineComponent(
        world,
        {
          value: RecsType.String,
        },
        {
          metadata: {
            contractId: tableId.toHexString(),
            tableId: tableId.toString(),
          },
        }
      );
    })(),
  };
}
