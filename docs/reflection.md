\# getrendersteppedlist



Returns a table of every callback that's bound using `BindToRenderStep`.



```lua

function getrendersteppedlist(): { function }

```



\## Example



This script will print every callback that's bound to 'RenderStepped'.



```lua

local connections = getrendersteppedlist()



for \_, callback in connections do

&#x20;   print("Function:", callback.Function)

&#x20;   print("Thread:", callback.Thread)

&#x20;   print("Priority:", callback.Priority)

&#x20;   print("Name:", callback.Name)

end

```



\---



\# getbspval



Reads a BinaryString property's value. Useful for reading conventionally unreadable BinaryString properties such as `Terrain.SmoothGrid`, `PartOperation.PhysicsData`, `BinaryStringValue.Value`, and so on.



```lua

function getbspval(instance: Instance, property: string, base64: boolean): string

```



\## Parameters



\### instance

`Instance` (required)



The Instance that contains the BinaryString's value.



\### property

`string` (required)



The name of the property read.



\### base64

`boolean`



Boolean indicating whether the BinaryString's value is Base64 encoded.



\## Example



```lua

local result = getbspval(workspace.Terrain, "SmoothGrid", true)

print(result) --> AQU= (Example output)

```



\---



\# getpcd



Returns a 16-byte hash and binary data corresponding to TriangleMeshPart's `PhysicalConfigData` property.



```lua

function getpcd(trianglemeshpart: Instance): string, string

```



\## Parameters



\### trianglemeshpart

`Instance` (required)



The Instance that contains the binary data.



\*\*Alias:\*\* `getpcdprop`



\## Example



This example prints the hash, and the BinaryData.



```lua

print(getpcd(Instance.new("UnionOperation")))

```



\---



\# getproximitypromptduration



Returns the value of a proximity prompt's duration.



```lua

function getproximitypromptduration(proximityprompt: ProximityPrompt): number

```



\## Parameters



\### proximityprompt

`ProximityPrompt` (required)



The ProximityPrompt that contains the duration.



\## Example



This script will print the duration of a proximity prompt.



```lua

local proximityprompt = Instance.new("ProximityPrompt")

proximityprompt.HoldDuration = 3



local duration = getproximitypromptduration(proximityprompt)

print(duration)

```



\---



\# setproximitypromptduration



Sets the value of a proximity prompt's duration.



```lua

function setproximitypromptduration(proximityprompt: ProximityPrompt, duration: number): ()

```



\## Parameters



\### proximityprompt

`ProximityPrompt` (required)



The ProximityPrompt that contains the duration.



\### duration

`number` (required)



The new duration of the ProximityPrompt.



\## Example



```lua

local proximityprompt = Instance.new("ProximityPrompt")

setproximitypromptduration(proximityprompt, 99)



local duration = getproximitypromptduration(proximityprompt)

print(duration) --> 99

```



\---



\# getsimulationradius



Returns the simulation radius of the LocalPlayer.



```lua

function getsimulationradius(): number

```



\## Example



```lua

print(getsimulationradius()) --> 1000

setsimulationradius(2000)

print(getsimulationradius()) --> 2000

```



\---



\# setsimulationradius



Sets the simulation radius of the LocalPlayer.



```lua

function setsimulationradius(simulationradius: number): ()

```



\## Parameters



\### simulationradius

`number` (required)



The LocalPlayer's new simulation radius.



\## Example



```lua

setsimulationradius(999)

print(getsimulationradius()) --> 999

```



\---



\# isnetworkowner



Returns boolean indicating whether the LocalPlayer is the network owner of a given instance.



```lua

function isnetworkowner(instance: Instance): boolean

```



\## Parameters



\### instance

`Instance` (required)



The Instance that the user has provided.



\## Example



```lua

local part = Instance.new("Part")

print(isnetworkowner(part))

```

