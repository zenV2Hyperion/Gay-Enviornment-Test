\# debug.getsafeenv



Returns the safeenv flag.



```lua

function debug.getsafeenv(object: function | table | thread)

```



\## Parameters



\### object

`function | table | thread` (required)



The object you would like to get the safeenv of.



\*\*Alias:\*\* `debug.isuntouched`



\## Example



All executed scripts are marked with safeenv as `false` for compatibility.



```lua

print(debug.getsafeenv()) --> false

debug.setsafeenv(true)

print(debug.getsafeenv()) --> true



\-- Since we are breaking safeenv protections by

\-- replacing a global function with getfenv, safeenv

\-- becomes false. Also applicable to setfenv.

getfenv().warn = function() end

print(debug.getsafeenv()) --> false

```



\---



\# debug.setsafeenv



Marks the safeenv for an object.



```lua

function debug.setsafeenv(func: function | table | thread | boolean, safe: boolean?)

```



\## Parameters



\### func

`function | table | thread | boolean` (required)



The object you would like to set the safeenv of. (If a boolean is provided it will set the current state's safeenv)



\### safe

`boolean`



What to set the safeenv of the `func` to.



\*\*Alias:\*\* `debug.setuntouched`



\## Example



Potassium marks safeenv to `false` in all executed scripts for compatibility.



```lua

print(debug.getsafeenv()) --> false

debug.setsafeenv(true)

print(debug.getsafeenv()) --> true



\-- Since we are breaking safeenv protections by

\-- replacing a global function with getfenv, safeenv

\-- becomes false. Also applicable to setfenv.

getfenv().warn = function() end

print(debug.getsafeenv()) --> false

```

