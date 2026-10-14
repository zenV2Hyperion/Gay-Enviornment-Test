# Changelog

## [1.0.0]

### Added

- `debug.getsafeenv` (alias `debug.isuntouched`) — verifies the function returns a boolean for the current state, functions, tables, and threads.
- `debug.setsafeenv` (alias `debug.setuntouched`) — verifies the function sets and restores the safeenv flag.
- `getrendersteppedlist` — verifies the function returns a table of `BindToRenderStep` callbacks with `Function`, `Thread`, `Priority`, and `Name` fields.
- `getbspval` — verifies the function returns a string for a BinaryString property.
- `getpcd` (alias `getpcdprop`) — verifies the function returns both a hash and binary data for a `TriangleMeshPart`.
- `getproximitypromptduration` — verifies the function returns the correct `HoldDuration` of a `ProximityPrompt`.
- `getsimulationradius` — verifies the function returns the LocalPlayer's simulation radius as a number.
- `isnetworkowner` — verifies the function returns a boolean for a given instance.
- `setproximitypromptduration` — verifies the function sets a `ProximityPrompt`'s duration.
- `setsimulationradius` — verifies the function sets and restores the LocalPlayer's simulation radius.
- `getprotohash` — verifies the function returns a string hash for a given callback.
- `getstackframe` — verifies the function returns a table or nil at a given stack level.
- `setcapability` — verifies the function accepts a capability level without erroring.
- `getcapability` — verifies the function returns the current capability level as a number.
- `replacetable` — verifies a table's contents are replaced in-place.
- `registercallback` — verifies a named callback can be registered without error.
- `unregistercallback` — verifies a named callback can be unregistered without error.
- `getluauheapusage` — verifies the function returns a non-negative number of bytes.
- `getthreadcapacity` — verifies the function returns a number.
- `dumpregisters` — verifies the function returns a table of registers.

### Notes

- Alias features (`debug.isuntouched`, `debug.setuntouched`, `getpcdprop`) are annotated with `(alias)` in the pass output.
- All test functions check that the target global exists before calling it, producing a `Function is missing` diagnostic instead of a raw Lua error.
- Summary line reports the success rate, author, and elapsed time.
