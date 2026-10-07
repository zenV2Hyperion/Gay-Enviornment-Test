# debug.getsafeenv

`Global`

```lua
function debug.getsafeenv(object: function | table | thread): boolean
```

Returns the **safeenv** flag of the given object.

### Parameters

 * `object` - The object you would like to get the safeenv of.

### Aliases

 * `debug.isuntouched`

### Example

All executed scripts are marked with safeenv as `false` for compatibility.

```lua
print(debug.getsafeenv()) --> false
debug.setsafeenv(true)
print(debug.getsafeenv()) --> true

-- Since we are breaking safeenv protections by
-- replacing a global function with getfenv, safeenv
-- becomes false. Also applicable to setfenv.
getfenv().warn = function() end
print(debug.getsafeenv()) --> false
```

---

# debug.setsafeenv

`Global`

```lua
function debug.setsafeenv(func: function | table | thread | boolean, safe: boolean?): ()
```

Marks the **safeenv** for an object.

### Parameters

 * `func` - The object you would like to set the safeenv of. If a boolean is provided it will set the current state's safeenv.
 * `safe` - What to set the safeenv of the `func` to.

### Aliases

 * `debug.setuntouched`

### Example

Potassium marks safeenv to `false` in all executed scripts for compatibility.

```lua
print(debug.getsafeenv()) --> false
debug.setsafeenv(true)
print(debug.getsafeenv()) --> true

-- Since we are breaking safeenv protections by
-- replacing a global function with getfenv, safeenv
-- becomes false. Also applicable to setfenv.
getfenv().warn = function() end
print(debug.getsafeenv()) --> false
```
