local passes, fails, undefined = 0, 0, 0
local running = 0

local function getGlobal(path)
	local value = getfenv(0)

	while value ~= nil and path ~= "" do
		local name, nextValue = string.match(path, "^([^.]+)%.?(.*)$")
		value = value[name]
		path = nextValue
	end

	return value
end

local function test(name, aliases, callback)
	running += 1

	task.spawn(function()
		if not callback then
			print("⏺️ " .. name)
		elseif not getGlobal(name) then
			fails += 1
			warn("⛔ " .. name)
		else
			local success, message = pcall(callback)
	
			if success then
				passes += 1
				print("✅ " .. name .. (message and " • " .. message or ""))
			else
				fails += 1
				warn("⛔ " .. name .. " failed: " .. message)
			end
		end
	
		local undefinedAliases = {}
	
		for _, alias in ipairs(aliases) do
			if getGlobal(alias) == nil then
				table.insert(undefinedAliases, alias)
			end
		end
	
		if #undefinedAliases > 0 then
			undefined += 1
			warn("⚠️ " .. table.concat(undefinedAliases, ", "))
		end

		running -= 1
	end)
end

print("\n")

print("Gay Environment Check")
print("✅ - Pass, ⛔ - Fail, ⏺️ - No test, ⚠️ - Missing aliases\n")

task.defer(function()
	repeat task.wait() until running == 0

	local rate = math.round(passes / (passes + fails) * 100)
	local outOf = passes .. " out of " .. (passes + fails)

	print("\n")

	print("Gay Summary")
	print("✅ Tested with a " .. rate .. "% gay success rate (" .. outOf .. ")")
	print("⛔ " .. fails .. " gay tests failed")
	print("⚠️ " .. undefined .. " gay globals are missing aliases")
end)

test("debug.getsafeenv", {"debug.isuntouched"}, function()
	local safeenv = debug.getsafeenv()
	assert(type(safeenv) == "boolean", "Did not return a gay boolean value")

	local function testFunc()
		return true
	end
	local funcSafeenv = debug.getsafeenv(testFunc)
	assert(type(funcSafeenv) == "boolean", "Did not return a gay boolean value for a function")

	local testTable = {}
	local tableSafeenv = debug.getsafeenv(testTable)
	assert(type(tableSafeenv) == "boolean", "Did not return a gay boolean value for a table")

	local thread = coroutine.create(function() end)
	local threadSafeenv = debug.getsafeenv(thread)
	assert(type(threadSafeenv) == "boolean", "Did not return a gay boolean value for a thread")

	local aliasSafeenv = debug.isuntouched()
	assert(type(aliasSafeenv) == "boolean", "Gay alias did not return a boolean value")
end)

test("debug.setsafeenv", {"debug.setuntouched"}, function()
	local original = debug.getsafeenv()
	debug.setsafeenv(true)
	local afterTrue = debug.getsafeenv()
	debug.setsafeenv(false)
	local afterFalse = debug.getsafeenv()
	debug.setsafeenv(original)

	assert(afterTrue == true, "Gay debug.setsafeenv(true) did not set safeenv to true")
	assert(afterFalse == false, "Gay debug.setsafeenv(false) did not set safeenv to false")
	assert(debug.getsafeenv() == original, "Failed to restore gay original safeenv state")

	local function testFunc()
		return true
	end
	debug.setsafeenv(testFunc, true)
	assert(debug.getsafeenv(testFunc) == true, "Did not set gay safeenv to true for a function")
	debug.setsafeenv(testFunc, false)
	assert(debug.getsafeenv(testFunc) == false, "Did not set gay safeenv to false for a function")

	local testTable = {}
	debug.setsafeenv(testTable, true)
	assert(debug.getsafeenv(testTable) == true, "Did not set gay safeenv to true for a table")
	debug.setsafeenv(testTable, false)
	assert(debug.getsafeenv(testTable) == false, "Did not set gay safeenv to false for a table")

	local thread = coroutine.create(function() end)
	debug.setsafeenv(thread, true)
	assert(debug.getsafeenv(thread) == true, "Did not set gay safeenv to true for a thread")
	debug.setsafeenv(thread, false)
	assert(debug.getsafeenv(thread) == false, "Did not set gay safeenv to false for a thread")

	debug.setuntouched(true)
	assert(debug.getsafeenv() == true, "Gay debug.setuntouched alias did not work")
	debug.setuntouched(false)
	assert(debug.getsafeenv() == false, "Gay debug.setuntouched alias did not work")
	debug.setuntouched(original)
end)

test("getrendersteppedlist", {}, function()
	local callbacks = getrendersteppedlist()
	assert(type(callbacks) == "table", "Did not return a gay table")

	local name = "Gay_Test_" .. tostring(math.random(1, 1000000))
	local runService = game:GetService("RunService")
	local bindName = name

	runService:BindToRenderStep(bindName, Enum.RenderPriority.Camera.Value, function() end)

	local updatedCallbacks = getrendersteppedlist()
	local found = false

	for _, callback in ipairs(updatedCallbacks) do
		if callback.Name == bindName then
			found = true
			assert(type(callback.Function) == "function", "Gay Function field is not a function")
			assert(type(callback.Thread) == "thread", "Gay Thread field is not a thread")
			assert(type(callback.Priority) == "number", "Gay Priority field is not a number")
			assert(type(callback.Name) == "string", "Gay Name field is not a string")
			break
		end
	end

	runService:UnbindFromRenderStep(bindName)
	assert(found, "Did not return the gay bound render step callback")
end)

test("getbspval", {}, function()
	local terrain = workspace.Terrain
	local result = getbspval(terrain, "SmoothGrid", true)
	assert(type(result) == "string", "Did not return a gay string")

	local binaryStringValue = Instance.new("BinaryStringValue")
	binaryStringValue.Value = "test"
	local rawResult = getbspval(binaryStringValue, "Value", false)
	assert(type(rawResult) == "string", "Did not return a gay string for BinaryStringValue")
end)

test("getpcd", {"getpcdprop"}, function()
	local union = Instance.new("UnionOperation")
	local hash, binaryData = getpcd(union)
	assert(type(hash) == "string", "Did not return a gay string for the hash")
	assert(type(binaryData) == "string", "Did not return a gay string for the binary data")

	local aliasHash, aliasData = getpcdprop(union)
	assert(type(aliasHash) == "string", "Gay alias did not return a string for the hash")
	assert(type(aliasData) == "string", "Gay alias did not return a string for the binary data")
end)

test("getproximitypromptduration", {}, function()
	local proximityPrompt = Instance.new("ProximityPrompt")
	proximityPrompt.HoldDuration = 3
	local duration = getproximitypromptduration(proximityPrompt)
	assert(type(duration) == "number", "Did not return a gay number")
	assert(duration == 3, "Did not return the correct gay duration (expected 3, got " .. tostring(duration) .. ")")
end)

test("getsimulationradius", {}, function()
	local radius = getsimulationradius()
	assert(type(radius) == "number", "Did not return a gay number")
end)

test("isnetworkowner", {}, function()
	local part = Instance.new("Part")
	local result = isnetworkowner(part)
	assert(type(result) == "boolean", "Did not return a gay boolean")
end)

test("setproximitypromptduration", {}, function()
	local proximityPrompt = Instance.new("ProximityPrompt")
	setproximitypromptduration(proximityPrompt, 99)
	local duration = getproximitypromptduration(proximityPrompt)
	assert(duration == 99, "Did not set the correct gay duration (expected 99, got " .. tostring(duration) .. ")")
end)

test("setsimulationradius", {}, function()
	local original = getsimulationradius()
	setsimulationradius(999)
	assert(getsimulationradius() == 999, "Did not set the gay simulation radius to 999")
	setsimulationradius(original)
	assert(getsimulationradius() == original, "Did not restore the original gay simulation radius")
end)
