# Gay Environment Check

aka Gay EC, is a test suite for executor developers and scripters to verify how well an executor's environment matches the expected API.

## Why?

Over the years, testing executors has gotten more and more annoying. Every executor implements a slightly different set of functions, and scripters have no easy way to know which ones actually work, which ones are stubbed, and which ones are missing entirely.

You end up writing scripts that say `if getprotohash then ... elseif getstackframe then ...` and hope for the best. That's not a good way to do it.

Gay EC solves this by giving you a single suite that tells you exactly what your executor supports, one line per function, no setup required. You run it, you read the output, you know what you're working with.

## How?

The suite is written in plain Luau and runs entirely in your executor. Each check is isolated with `pcall` so a failure in one function doesn't stop the rest of the tests from running.

The suite reports four kinds of results:

| Symbol | Meaning |
| ------ | ------- |
| ✅ | passed — the function exists and behaves correctly. |
| ⛔ | failed — the function exists but returned the wrong thing, threw an error, or is missing entirely. |
| ⏺️ | no test — no test was provided for that function. |
| ⚠️ | missing alias — the function works but one or more of its expected aliases are missing. |

Aliases are marked with `(alias)` next to the name so you know they're not the primary function.

If a function doesn't exist at all, you get a clean `Function is missing` message instead of a raw Lua error blowing up the whole run.

## Checking your environment

Paste the suite into your executor and execute it

Or just loadstring it:

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/zenV2Hyperion/Gay-Enviornment-Test/refs/heads/main/Tes.lua",true))()
```

## What it checks

- `debug.getsafeenv`
- `debug.setsafeenv`
- `getrendersteppedlist`
- `getbspval`
- `getpcd`
- `getproximitypromptduration`
- `getsimulationradius`
- `isnetworkowner`
- `setproximitypromptduration`
- `setsimulationradius`
- `getprotohash`
- `getstackframe`
- `setcapability`
- `getcapability`
- `replacetable`
- `registercallback`
- `unregistercallback`
- `getluauheapusage`
- `getthreadcapacity`
- `dumpregisters`

## Notes

Aliases show up with `(alias)` next to them so you know they're not the main function.

If a function doesn't exist, you get `⛔ name failed: Function is missing` instead of an error blowing up the whole run.

## Credits

Made by zenV2.

## Changelog

See [CHANGELOG.md](./CHANGELOG.md).
