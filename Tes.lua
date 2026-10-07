local function resolve_environment(environment)
    return environment or (getgenv and getgenv()) or _G
end

local function fail_test(captures, feature, detail)
    captures = captures or {}
    local record = captures.record_result
    if record then record(false, feature, detail) end
    captures.shared_test_failed[1] = true
    return false
end

local function safe_destroy(object)
    if object and object.Destroy then pcall(function() object:Destroy() end) end
end

local function test_debug_getsafeenv(environment, captures)
    environment = resolve_environment(environment)
    captures = captures or {}

    local safeenv = environment.debug.getsafeenv()
    if type(safeenv) ~= "boolean" then
        return fail_test(captures, "debug.getsafeenv", "Did not return a boolean value")
    end

    local function testFunc() return true end
    if type(environment.debug.getsafeenv(testFunc)) ~= "boolean" then
        fail_test(captures, "debug.getsafeenv", "Did not return a boolean value for a function")
    end

    if type(environment.debug.getsafeenv({})) ~= "boolean" then
        fail_test(captures, "debug.getsafeenv", "Did not return a boolean value for a table")
    end

    local thread = coroutine.create(function() end)
    if type(environment.debug.getsafeenv(thread)) ~= "boolean" then
        fail_test(captures, "debug.getsafeenv", "Did not return a boolean value for a thread")
    end

    if type(environment.debug.isuntouched()) ~= "boolean" then
        fail_test(captures, "debug.getsafeenv", "Alias did not return a boolean value")
    end
end

local function test_debug_setsafeenv(environment, captures)
    environment = resolve_environment(environment)
    captures = captures or {}

    local original = environment.debug.getsafeenv()
    environment.debug.setsafeenv(true)
    if environment.debug.getsafeenv() ~= true then
        fail_test(captures, "debug.setsafeenv", "debug.setsafeenv(true) did not set safeenv to true")
    end
    environment.debug.setsafeenv(false)
    if environment.debug.getsafeenv() ~= false then
        fail_test(captures, "debug.setsafeenv", "debug.setsafeenv(false) did not set safeenv to false")
    end
    environment.debug.setsafeenv(original)
    if environment.debug.getsafeenv() ~= original then
        fail_test(captures, "debug.setsafeenv", "Failed to restore original safeenv state")
    end

    local function testFunc() return true end
    environment.debug.setsafeenv(testFunc, true)
    if environment.debug.getsafeenv(testFunc) ~= true then
        fail_test(captures, "debug.setsafeenv", "Did not set safeenv to true for a function")
    end
    environment.debug.setsafeenv(testFunc, false)
    if environment.debug.getsafeenv(testFunc) ~= false then
        fail_test(captures, "debug.setsafeenv", "Did not set safeenv to false for a function")
    end

    local testTable = {}
    environment.debug.setsafeenv(testTable, true)
    if environment.debug.getsafeenv(testTable) ~= true then
        fail_test(captures, "debug.setsafeenv", "Did not set safeenv to true for a table")
    end
    environment.debug.setsafeenv(testTable, false)
    if environment.debug.getsafeenv(testTable) ~= false then
        fail_test(captures, "debug.setsafeenv", "Did not set safeenv to false for a table")
    end

    local thread = coroutine.create(function() end)
    environment.debug.setsafeenv(thread, true)
    if environment.debug.getsafeenv(thread) ~= true then
        fail_test(captures, "debug.setsafeenv", "Did not set safeenv to true for a thread")
    end
    environment.debug.setsafeenv(thread, false)
    if environment.debug.getsafeenv(thread) ~= false then
        fail_test(captures, "debug.setsafeenv", "Did not set safeenv to false for a thread")
    end

    environment.debug.setuntouched(true)
    if environment.debug.getsafeenv() ~= true then
        fail_test(captures, "debug.setsafeenv", "debug.setuntouched alias did not work")
    end
    environment.debug.setuntouched(false)
    if environment.debug.getsafeenv() ~= false then
        fail_test(captures, "debug.setsafeenv", "debug.setuntouched alias did not work")
    end
    environment.debug.setuntouched(original)
end

local function test_getrendersteppedlist(environment, captures)
    environment = resolve_environment(environment)
    captures = captures or {}

    local callbacks = environment.getrendersteppedlist()
    if type(callbacks) ~= "table" then
        return fail_test(captures, "getrendersteppedlist", "Did not return a table")
    end

    local name = "Gay_Test_" .. tostring(math.random(1, 1000000))
    local runService = environment.game:GetService("RunService")
    local bindName = name

    runService:BindToRenderStep(bindName, environment.Enum.RenderPriority.Camera.Value, function() end)

    local updatedCallbacks = environment.getrendersteppedlist()
    local found = false

    for _, callback in ipairs(updatedCallbacks) do
        if callback.Name == bindName then
            found = true
            if type(callback.Function) ~= "function" then
                fail_test(captures, "getrendersteppedlist", "Function field is not a function")
            end
            if type(callback.Thread) ~= "thread" then
                fail_test(captures, "getrendersteppedlist", "Thread field is not a thread")
            end
            if type(callback.Priority) ~= "number" then
                fail_test(captures, "getrendersteppedlist", "Priority field is not a number")
            end
            if type(callback.Name) ~= "string" then
                fail_test(captures, "getrendersteppedlist", "Name field is not a string")
            end
            break
        end
    end

    runService:UnbindFromRenderStep(bindName)
    if not found then
        fail_test(captures, "getrendersteppedlist", "Did not return the bound render step callback")
    end
end

local function test_getbspval(environment, captures)
    environment = resolve_environment(environment)
    captures = captures or {}

    local terrain = environment.workspace.Terrain
    local result = environment.getbspval(terrain, "SmoothGrid", true)
    if type(result) ~= "string" then
        fail_test(captures, "getbspval", "Did not return a string")
    end

    local binaryStringValue = environment.Instance.new("BinaryStringValue")
    binaryStringValue.Value = "test"
    local rawResult = environment.getbspval(binaryStringValue, "Value", false)
    if type(rawResult) ~= "string" then
        fail_test(captures, "getbspval", "Did not return a string for BinaryStringValue")
    end
end

local function test_getpcd(environment, captures)
    environment = resolve_environment(environment)
    captures = captures or {}

    local union = environment.Instance.new("UnionOperation")
    local hash, binaryData = environment.getpcd(union)
    if type(hash) ~= "string" then
        fail_test(captures, "getpcd", "Did not return a string for the hash")
    end
    if type(binaryData) ~= "string" then
        fail_test(captures, "getpcd", "Did not return a string for the binary data")
    end

    local aliasHash, aliasData = environment.getpcdprop(union)
    if type(aliasHash) ~= "string" then
        fail_test(captures, "getpcd", "Alias did not return a string for the hash")
    end
    if type(aliasData) ~= "string" then
        fail_test(captures, "getpcd", "Alias did not return a string for the binary data")
    end
end

local function test_getproximitypromptduration(environment, captures)
    environment = resolve_environment(environment)
    captures = captures or {}

    local proximityPrompt = environment.Instance.new("ProximityPrompt")
    proximityPrompt.HoldDuration = 3
    local duration = environment.getproximitypromptduration(proximityPrompt)
    if type(duration) ~= "number" then
        fail_test(captures, "getproximitypromptduration", "Did not return a number")
    end
    if duration ~= 3 then
        fail_test(captures, "getproximitypromptduration",
            "Did not return the correct duration (expected 3, got " .. tostring(duration) .. ")")
    end
end

local function test_getsimulationradius(environment, captures)
    environment = resolve_environment(environment)
    captures = captures or {}

    local radius = environment.getsimulationradius()
    if type(radius) ~= "number" then
        fail_test(captures, "getsimulationradius", "Did not return a number")
    end
end

local function test_isnetworkowner(environment, captures)
    environment = resolve_environment(environment)
    captures = captures or {}

    local part = environment.Instance.new("Part")
    local result = environment.isnetworkowner(part)
    if type(result) ~= "boolean" then
        fail_test(captures, "isnetworkowner", "Did not return a boolean")
    end
    safe_destroy(part)
end

local function test_setproximitypromptduration(environment, captures)
    environment = resolve_environment(environment)
    captures = captures or {}

    local proximityPrompt = environment.Instance.new("ProximityPrompt")
    environment.setproximitypromptduration(proximityPrompt, 99)
    local duration = environment.getproximitypromptduration(proximityPrompt)
    if duration ~= 99 then
        fail_test(captures, "setproximitypromptduration",
            "Did not set the correct duration (expected 99, got " .. tostring(duration) .. ")")
    end
end

local function test_setsimulationradius(environment, captures)
    environment = resolve_environment(environment)
    captures = captures or {}

    local original = environment.getsimulationradius()
    environment.setsimulationradius(999)
    if environment.getsimulationradius() ~= 999 then
        fail_test(captures, "setsimulationradius", "Did not set the simulation radius to 999")
    end
    environment.setsimulationradius(original)
    if environment.getsimulationradius() ~= original then
        fail_test(captures, "setsimulationradius", "Did not restore the original simulation radius")
    end
end

local TEST_PLAN = {
    { test = "debug.getsafeenv", run = test_debug_getsafeenv, features = { "debug.getsafeenv", "debug.isuntouched" } },
    { test = "debug.setsafeenv", run = test_debug_setsafeenv, features = { "debug.setsafeenv", "debug.setuntouched" } },
    { test = "getrendersteppedlist", run = test_getrendersteppedlist },
    { test = "getbspval", run = test_getbspval },
    { test = "getpcd", run = test_getpcd, features = { "getpcd", "getpcdprop" } },
    { test = "getproximitypromptduration", run = test_getproximitypromptduration },
    { test = "getsimulationradius", run = test_getsimulationradius },
    { test = "isnetworkowner", run = test_isnetworkowner },
    { test = "setproximitypromptduration", run = test_setproximitypromptduration },
    { test = "setsimulationradius", run = test_setsimulationradius },
}

local function copy_array(values)
    local result = {}
    for index, value in ipairs(values or {}) do result[index] = value end
    return result
end

local function run_gay_suite(environment, options)
    environment = resolve_environment(environment)
    options = options or {}

    local output = environment.print or print
    local warning = environment.warn or warn
    local clock = environment.tick or tick
    local started_at = clock()

    output("Testing gay env")

    local results_by_name = {}
    local shared_test_failed = { false }

    local function record_result(passed, feature, detail)
        feature = tostring(feature)
        local previous = results_by_name[feature]
        if previous == nil or previous.passed or passed == false then
            results_by_name[feature] = {
                test = feature,
                passed = passed == true,
                detail = detail,
            }
        end
        if not passed then
            shared_test_failed[1] = true
            warning("⛔ " .. feature .. (detail and (" failed: " .. tostring(detail)) or ""))
        else
            output("✅ " .. feature)
        end
        return passed
    end

    local captures = {
        options = options,
        record_result = record_result,
        output = warning,
        shared_test_failed = shared_test_failed,
        make_probe_value = function(minimum, maximum)
            if type(environment.newproxy) == "function" then return environment.newproxy(true) end
            return math.random(minimum or 0, maximum or 2^30)
        end,
    }

    for _, specification in ipairs(TEST_PLAN) do
        local features = copy_array(specification.features or { specification.test })
        local succeeded, error_message = pcall(specification.run, environment, captures)
        if not succeeded then
            for _, feature in ipairs(features) do
                record_result(false, feature, "The function failed to be tested: " .. tostring(error_message))
            end
        else
            for _, feature in ipairs(features) do
                if results_by_name[feature] == nil then
                    record_result(true, feature)
                end
            end
        end
    end

    local passed_count, failed_count = 0, 0
    for _, result in pairs(results_by_name) do
        if result.passed then passed_count = passed_count + 1 else failed_count = failed_count + 1 end
    end
    local evaluated_count = passed_count + failed_count
    local rate = evaluated_count > 0 and math.floor((passed_count / evaluated_count) * 100 + 0.5) or 0
    local elapsed_seconds = math.floor((clock() - started_at) * 100) / 100

    print("Tested with a " .. rate .. "% success rate (" .. passed_count .. " out of " .. evaluated_count .. ")")
    print("This gay test was made by zenV2")
    print("Finished the gay test in " .. tostring(elapsed_seconds) .. " seconds")

    return results_by_name, not shared_test_failed[1]
end

run_gay_suite((getgenv and getgenv()) or _G)
