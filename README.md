# axeBlackMarket

A dynamic Black Market script for FiveM that features a moving merchant. The black market NPC appears at random locations, stays open for a limited time, then disappears and reopens somewhere else—keeping players on their toes.

## Installation

**Plug & Play** — Simply add the resource to your server and start it. No database setup or extra configuration required beyond editing `config.lua` to suit your server.

1. Place the `axeBlackMarket` folder in your server's `resources` directory
2. Add `ensure axeBlackMarket` to your `server.cfg` (after your dependencies)
3. Restart your server or start the resource

## Dependencies

- **QBCore** — Framework
- **qb-inventory** — Inventory & shop system
- **qb-target** — Interaction

Ensure these resources are started **before** axeBlackMarket in your `server.cfg`.

## How It Works

- The black market merchant spawns at a random location from your config
- It stays **open** for a set duration (e.g. 10 minutes)
- Then it **closes** and disappears for a cooldown period (e.g. 5 minutes)
- When it reopens, players receive a notification with a tip hinting where to find it
- Players interact with the NPC via qb-target to open the shop

## Configuration

All settings are in `config.lua`.

### Config.BlackMarket

| Option | Type | Description |
|--------|------|-------------|
| `label` | string | Display name of the black market shop |
| `ped` | hash | GTA V ped model (e.g. `g_m_importexport_01`) |
| `interactText` | string | Text shown on the qb-target interaction |
| `durationInMinutes` | number | How long the black market stays open (in minutes) |
| `timeToChangeLocationInMinutes` | number | Cooldown between locations—how long to wait before reopening at a new spot (in minutes) |
| `textWhenBlackMerchantLeft` | string | Message shown to players when the market is closed |

### Config.Locations

An array of spawn points. Each entry:

| Option | Type | Description |
|--------|------|-------------|
| `coords` | vector4 | `x, y, z, heading` — Where the NPC spawns |
| `tip` | string | Hint sent to players when the market opens at this location (e.g. *"Find me behind the city bank."*) |

Example:
```lua
{
    coords = vector4(145.96, -1058.95, 30.19, 64.87),
    tip = "Find me behind the city bank.",
},
```

### Config.BlackMarketItems

Items sold at the black market. Each entry:

| Option | Type | Description |
|--------|------|-------------|
| `name` | string | Item name (must exist in your qb-core/shared items) |
| `price` | number | Price per unit |
| `amount.min` | number | Minimum stock amount per restock |
| `amount.max` | number | Maximum stock amount per restock |

Example:
```lua
{
    name = "weapon_pistol",
    price = 1000,
    amount = { min = 0, max = 1 },
},
```

Stock is randomized between `min` and `max` each time the market reopens at a new location.

---

*AXE Scripts — Black Market for QBCore*
