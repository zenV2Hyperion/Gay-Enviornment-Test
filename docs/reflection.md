# getrendersteppedlist

`Global`

```lua
function getrendersteppedlist(): { function }
```

Returns a **table** of every callback that's bound using `BindToRenderStep`.

### Example

This script will print every callback that's bound to **RenderStepped**.

```lua
local connections = getrendersteppedlist()

for _, callback in connections do
    print("Function:", callback.Function)
    print("Thread:", callback.Thread)
    print("Priority:", callback.Priority)
    print("Name:", callback.Name)
end
```

---

# getbspval

`Global`

```lua
function getbspval(instance: Instance, property: string, base64: boolean): string
```

Reads a **BinaryString** property's value. Useful for reading conventionally unreadable BinaryString properties such as `Terrain.SmoothGrid`, `PartOperation.PhysicsData`, `BinaryStringValue.Value`, and so on.

### Parameters

 * `instance` - The Instance that contains the BinaryString's value.
 * `property` - The name of the property read.
 * `base64` - Boolean indicating whether the BinaryString's value is Base64 encoded.

### Example

```lua
local result = getbspval(workspace.Terrain, "SmoothGrid", true)
print(result) --> AQU= (Example output)
```

---

# getpcd

`Global`

```lua
function getpcd(trianglemeshpart: Instance): string, string
```

Returns a **16-byte hash** and **binary data** corresponding to TriangleMeshPart's `PhysicalConfigData` property.

### Parameters

 * `trianglemeshpart` - The Instance that contains the binary data.

### Aliases

 * `getpcdprop`

### Example

This example prints the hash, and the BinaryData.

```lua
print(getpcd(Instance.new("UnionOperation")))
```

---

# getproximitypromptduration

`Global`

```lua
function getproximitypromptduration(proximityprompt: ProximityPrompt): number
```

Returns the value of a proximity prompt's **duration**.

### Parameters

 * `proximityprompt` - The ProximityPrompt that contains the duration.

### Example

This script will print the duration of a proximity prompt.

```lua
local proximityprompt = Instance.new("ProximityPrompt")
proximityprompt.HoldDuration = 3

local duration = getproximitypromptduration(proximityprompt)
print(duration)
```

---

# setproximitypromptduration

`Global`

```lua
function setproximitypromptduration(proximityprompt: ProximityPrompt, duration: number): ()
```

Sets the value of a proximity prompt's **duration**.

### Parameters

 * `proximityprompt` - The ProximityPrompt that contains the duration.
 * `duration` - The new duration of the ProximityPrompt.

### Example

```lua
local proximityprompt = Instance.new("ProximityPrompt")
setproximitypromptduration(proximityprompt, 99)

local duration = getproximitypromptduration(proximityprompt)
print(duration) --> 99
```

---

# getsimulationradius

`Global`

```lua
function getsimulationradius(): number
```

Returns the **simulation radius** of the LocalPlayer.

### Example

```lua
print(getsimulationradius()) --> 1000
setsimulationradius(2000)
print(getsimulationradius()) --> 2000
```

---

# setsimulationradius

`Global`

```lua
function setsimulationradius(simulationradius: number): ()
```

Sets the **simulation radius** of the LocalPlayer.

### Parameters

 * `simulationradius` - The LocalPlayer's new simulation radius.

### Example

```lua
setsimulationradius(999)
print(getsimulationradius()) --> 999
```

---

# isnetworkowner

`Global`

```lua
function isnetworkowner(instance: Instance): boolean
```

Returns a boolean indicating whether the LocalPlayer is the **network owner** of a given instance.

### Parameters

 * `instance` - The Instance that the user has provided.

### Example

```lua
local part = Instance.new("Part")
print(isnetworkowner(part))
```

---

# getprotohash

`Global`

```lua
function getprotohash(callback: function): string
```

Returns a **hash string** identifying the proto of a given function.

### Parameters

 * `callback` - The function whose proto hash you want to retrieve.

### Example

```lua
local hash = getprotohash(print)
print(hash) --> "a4c1f0e2..."
```

---

# getstackframe

`Global`

```lua
function getstackframe(level: number): table?
```

Returns the **stack frame** at the given level, or `nil` if the level does not exist.

### Parameters

 * `level` - The stack level to inspect. Level 1 is the caller of `getstackframe`.

### Example

```lua
local frame = getstackframe(1)
print(frame and frame.source, frame and frame.currentline)
```

---

# setcapability

`Global`

```lua
function setcapability(capability: number): ()
```

Sets the **capability level** of the current thread.

### Parameters

 * `capability` - The new capability level for the calling thread.

### Example

```lua
setcapability(6)
print(getcapability()) --> 6
```

---

# getcapability

`Global`

```lua
function getcapability(): number
```

Returns the **capability level** of the calling thread.

### Example

```lua
print(getcapability()) --> 2
setcapability(8)
print(getcapability()) --> 8
```

---

# replacetable

`Global`

```lua
function replacetable(target: table, source: table): ()
```

Replaces the contents of one table with another **in-place**. The original table reference is preserved.

### Parameters

 * `target` - The table whose contents will be overwritten.
 * `source` - The table whose contents will be copied into `target`.

### Example

```lua
local original = { 1, 2, 3 }
local replacement = { 4, 5, 6 }
replacetable(original, replacement)
print(original[1]) --> 4
```

---

# registercallback

`Global`

```lua
function registercallback(name: string, callback: function): ()
```

Registers a **named callback** that the executor can invoke later by name.

### Parameters

 * `name` - The unique name to register the callback under.
 * `callback` - The function to invoke when the callback is triggered.

### Example

```lua
registercallback("sunc_probe", function()
    print("callback fired")
end)
```

---

# unregistercallback

`Global`

```lua
function unregistercallback(name: string): ()
```

Removes a previously registered **callback** by name.

### Parameters

 * `name` - The name of the callback to remove.

### Example

```lua
unregistercallback("sunc_probe")
```

---

# getluauheapusage

`Global`

```lua
function getluauheapusage(): number
```

Returns the current **Luau heap usage** in bytes.

### Example

```lua
local usage = getluauheapusage()
print(usage) --> 1048576
```

---

# getthreadcapacity

`Global`

```lua
function getthreadcapacity(): number
```

Returns the **capacity** of the current thread.

### Example

```lua
print(getthreadcapacity()) --> 200
```

---

# dumpregisters

`Global`

```lua
function dumpregisters(callback: function): table
```

Returns a table containing the **registers** of a given function's proto.

### Parameters

 * `callback` - The function whose registers you want to dump.

### Example

```lua
local registers = dumpregisters(function() end)
for index, value in pairs(registers) do
    print(index, value)
end
```
