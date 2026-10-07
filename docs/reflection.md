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
