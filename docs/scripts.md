# getscriptthreadid

`Global`

```lua
function getscriptthreadid(script: Instance): number
```

Returns the **thread ID** of a running script.

### Parameters

 * `script` - The script whose thread ID you want to retrieve.

### Example

```lua
local id = getscriptthreadid(game.Players.LocalPlayer.PlayerScripts.Animate)
print(id) --> 40291
```

---

# getscriptexecutiontime

`Global`

```lua
function getscriptexecutiontime(script: Instance): number
```

Returns how long a script has been **executing**, in seconds.

### Parameters

 * `script` - The script whose execution time you want to measure.

### Example

```lua
print(getscriptexecutiontime(game.Players.LocalPlayer.PlayerScripts.Animate)) --> 12.53
```

---

# getscriptsourcemap

`Global`

```lua
function getscriptsourcemap(script: Instance): table
```

Returns the **source map** for a decompiled script, mapping bytecode offsets back to source lines.

### Parameters

 * `script` - The script whose source map you want to retrieve.

### Example

```lua
local map = getscriptsourcemap(game.Workspace.Script)
for offset, line in pairs(map) do
    print(offset, line)
end
```

---

# isscriptpaused

`Global`

```lua
function isscriptpaused(script: Instance): boolean
```

Returns whether a running script is currently **paused**.

### Parameters

 * `script` - The script to check.

### Example

```lua
print(isscriptpaused(game.Workspace.Script)) --> false
```

---

# pausescript

`Global`

```lua
function pausescript(script: Instance): ()
```

Pauses a running script's thread.

### Parameters

 * `script` - The script to pause.

### Example

```lua
pausescript(game.Workspace.Script)
print(isscriptpaused(game.Workspace.Script)) --> true
```

---

# resumescript

`Global`

```lua
function resumescript(script: Instance): ()
```

Resumes a previously paused script's thread.

### Parameters

 * `script` - The script to resume.

### Example

```lua
resumescript(game.Workspace.Script)
print(isscriptpaused(game.Workspace.Script)) --> false
```

---

# getscriptparentmodule

`Global`

```lua
function getscriptparentmodule(script: Instance): Instance?
```

Returns the **ModuleScript** a script was required from, or `nil` if the script was not required by a module.

### Parameters

 * `script` - The script whose parent module you want to retrieve.

### Example

```lua
local parent = getscriptparentmodule(game.Workspace.Script)
print(parent and parent.Name or "no parent module")
```

---

# getscriptexecutioncontext

`Global`

```lua
function getscriptexecutioncontext(script: Instance): string
```

Returns the **execution context** (`Client`, `Server`, or `Plugin`) a script is running in.

### Parameters

 * `script` - The script whose execution context you want to retrieve.

### Example

```lua
print(getscriptexecutioncontext(game.Workspace.Script)) --> "Server"
```

---

# getscriptcallstack

`Global`

```lua
function getscriptcallstack(script: Instance): table
```

Returns the **call stack** of a running script as a table of frame entries.

### Parameters

 * `script` - The script whose call stack you want to inspect.

### Example

```lua
local stack = getscriptcallstack(game.Workspace.Script)
for index, frame in ipairs(stack) do
    print(index, frame.source, frame.line)
end
```

---

# getscriptthreadstate

`Global`

```lua
function getscriptthreadstate(script: Instance): string
```

Returns the current **state** of a script's thread (`Running`, `Suspended`, `Dead`, or `Normal`).

### Parameters

 * `script` - The script whose thread state you want to retrieve.

### Example

```lua
print(getscriptthreadstate(game.Workspace.Script)) --> "Running"
```
