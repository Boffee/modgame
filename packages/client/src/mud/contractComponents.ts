/* Autogenerated file. Do not edit manually. */

import { TableId } from "@latticexyz/utils";
import { defineComponent, Type as RecsType, World } from "@latticexyz/recs";

export function defineContractComponents(world: World) {
  return {
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
    Counter: (() => {
      const tableId = new TableId("", "Counter");
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
    Creature: (() => {
      const tableId = new TableId("", "Creature");
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
    CreatureStats: (() => {
      const tableId = new TableId("", "CreatureStats");
      return defineComponent(
        world,
        {
          lifespan: RecsType.Number,
          moveDistance: RecsType.Number,
          moveCooldown: RecsType.Number,
          attackDistance: RecsType.Number,
          attackCooldown: RecsType.Number,
          cooldownReserveCapacity: RecsType.Number,
        },
        {
          metadata: {
            contractId: tableId.toHexString(),
            tableId: tableId.toString(),
          },
        }
      );
    })(),
    Diet: (() => {
      const tableId = new TableId("", "Diet");
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
    Drop: (() => {
      const tableId = new TableId("", "Drop");
      return defineComponent(
        world,
        {
          primaryResource: RecsType.String,
          secondaryResource: RecsType.String,
          primaryResourceQuantity: RecsType.BigInt,
          secondaryResourceQuantity: RecsType.BigInt,
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
    Mutation: (() => {
      const tableId = new TableId("", "Mutation");
      return defineComponent(
        world,
        {
          parent: RecsType.String,
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
          readyAt: RecsType.Number,
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
  };
}
