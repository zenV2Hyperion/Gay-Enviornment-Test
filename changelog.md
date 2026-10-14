# Changelog

## [1.1.0]

### Added

#### Reflection

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

#### Scripts

- `getscriptthreadid` — verifies the function returns the thread ID of a running script as a number.
- `getscriptexecutiontime` — verifies the function returns how long a script has been executing, in seconds.
- `getscriptsourcemap` — verifies the function returns a source map table for a decompiled script.
- `isscriptpaused` — verifies the function returns whether a running script is paused.
- `pausescript` — verifies the function pauses a running script without erroring.
- `resumescript` — verifies the function resumes a previously paused script without erroring.
- `getscriptparentmodule` — verifies the function returns the parent module of a script, or `nil`.
- `getscriptexecutioncontext` — verifies the function returns the execution context of a script.
- `getscriptcallstack` — verifies the function returns the call stack of a script as a table.
- `getscriptthreadstate` — verifies the function returns the current state of a script's thread.

### Notes

- All script-related tests use a shared `find_first_running_script` helper to locate a suitable fixture, falling back to `getrunningscripts` when the LocalPlayer's `Animate` script is unavailable.
