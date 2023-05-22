Hook Callstack:

```mermaid
graph TD;
  c{Client} -.-> w[World]
  w --> s[Move/Attack/etc. Systems]
  s --> ps[Physics Subsystems]
  ps --trigger hook--> php[Permissioned\nProxy Subsystem]
  php --delegatecall--> h[Hook Handler\nImplementation System]
  w --> ets[Entity Trigger System]
  ets --> php
  h --> ps
```

Entities have:

- stats
- actions
- reactions

# Access Control

All mods inherit the access control of the `Permissioned Proxy Subsystem`, which is restricted to only the `Physics Subsystems`. This means mods are bound by the physics of the world defined in the `Physics Subsystems`.

All mods are implemented as unregistered systems that are `delegatecall`ed by the `Permissioned Proxy Subsystem` to enforce access control.

# Mods

Mods can create temporary entities.

# Game Modes

## Anarchy

All mods are allowed in the game.

## Standard

A list of approved mods are are included in the game. Mods are assigned tier, which is used to determine the drop rate.

# Governance

## Mods

Players decide what mods get included in the standard game mode in two stages:

1. **Vote for inclusion**: the mods with the most votes are included in the game
2. **Vote for tier**: players re-vote for the frequency of the included mods
