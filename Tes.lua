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

    if type(environment.debug.getsafeenv) ~= "function" then
        return fail_test(captures, "debug.getsafeenv", "Function is missing")
    end

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
end

local function test_debug_setsafeenv(environment, captures)
    environment = resolve_environment(environment)
    captures = captures or {}

    if type(environment.debug.setsafeenv) ~= "function" then
        return fail_test(captures, "debug.setsafeenv", "Function is missing")
    end

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
end

local function test_getrendersteppedlist(environment, captures)
    environment = resolve_environment(environment)
    captures = captures or {}

    if type(environment.getrendersteppedlist) ~= "function" then
        return fail_test(captures, "getrendersteppedlist", "Function is missing")
    end

    local callbacks = environment.getrendersteppedlist()
    if type(callbacks) ~= "table" then
        return fail_test(captures, "getrendersteppedlist", "Did not return a table")
    end

    local bindName = "Gay_Test_" .. tostring(math.random(1, 1000000))
    local runService = environment.game:GetService("RunService")
    runService:BindToRenderStep(bindName, environment.Enum.RenderPriority.Camera.Value, function() end)

    local found = false
    for _, callback in ipairs(environment.getrendersteppedlist()) do
        if callback.Name == bindName then
            found = true
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

    if type(environment.getbspval) ~= "function" then
        return fail_test(captures, "getbspval", "Function is missing")
    end

    local result = environment.getbspval(environment.workspace.Terrain, "SmoothGrid", true)
    if type(result) ~= "string" then
        fail_test(captures, "getbspval", "Did not return a string")
    end
end

local function test_getpcd(environment, captures)
    environment = resolve_environment(environment)
    captures = captures or {}

    if type(environment.getpcd) ~= "function" then
        return fail_test(captures, "getpcd", "Function is missing")
    end

    local union = environment.Instance.new("UnionOperation")
    local hash, binaryData = environment.getpcd(union)
    if type(hash) ~= "string" then
        fail_test(captures, "getpcd", "Did not return a string for the hash")
    end
    if type(binaryData) ~= "string" then
        fail_test(captures, "getpcd", "Did not return a string for the binary data")
    end
end

local function test_getproximitypromptduration(environment, captures)
    environment = resolve_environment(environment)
    captures = captures or {}

    if type(environment.getproximitypromptduration) ~= "function" then
        return fail_test(captures, "getproximitypromptduration", "Function is missing")
    end

    local proximityPrompt = environment.Instance.new("ProximityPrompt")
    proximityPrompt.HoldDuration = 3
    if environment.getproximitypromptduration(proximityPrompt) ~= 3 then
        fail_test(captures, "getproximitypromptduration", "Did not return the correct duration")
    end
end

local function test_getsimulationradius(environment, captures)
    environment = resolve_environment(environment)
    captures = captures or {}

    if type(environment.getsimulationradius) ~= "function" then
        return fail_test(captures, "getsimulationradius", "Function is missing")
    end

    if type(environment.getsimulationradius()) ~= "number" then
        fail_test(captures, "getsimulationradius", "Did not return a number")
    end
end

local function test_isnetworkowner(environment, captures)
    environment = resolve_environment(environment)
    captures = captures or {}

    if type(environment.isnetworkowner) ~= "function" then
        return fail_test(captures, "isnetworkowner", "Function is missing")
    end

    local part = environment.Instance.new("Part")
    if type(environment.isnetworkowner(part)) ~= "boolean" then
        fail_test(captures, "isnetworkowner", "Did not return a boolean")
    end
    safe_destroy(part)
end

local function test_setproximitypromptduration(environment, captures)
    environment = resolve_environment(environment)
    captures = captures or {}

    if type(environment.setproximitypromptduration) ~= "function" then
        return fail_test(captures, "setproximitypromptduration", "Function is missing")
    end

    local proximityPrompt = environment.Instance.new("ProximityPrompt")
    environment.setproximitypromptduration(proximityPrompt, 99)
    if environment.getproximitypromptduration(proximityPrompt) ~= 99 then
        fail_test(captures, "setproximitypromptduration", "Did not set the correct duration")
    end
end

local function test_setsimulationradius(environment, captures)
    environment = resolve_environment(environment)
    captures = captures or {}

    if type(environment.setsimulationradius) ~= "function" then
        return fail_test(captures, "setsimulationradius", "Function is missing")
    end

    local original = environment.getsimulationradius()
    environment.setsimulationradius(999)
    if environment.getsimulationradius() ~= 999 then
        fail_test(captures, "setsimulationradius", "Did not set the simulation radius to 999")
    end
    environment.setsimulationradius(original)
end

local function test_getprotohash(environment, captures)
    environment = resolve_environment(environment)
    captures = captures or {}

    if type(environment.getprotohash) ~= "function" then
        return fail_test(captures, "getprotohash", "Function is missing")
    end

    local hash = environment.getprotohash(function() end)
    if type(hash) ~= "string" then
        fail_test(captures, "getprotohash", "Did not return a string")
    end
end

local function test_getstackframe(environment, captures)
    environment = resolve_environment(environment)
    captures = captures or {}

    if type(environment.getstackframe) ~= "function" then
        return fail_test(captures, "getstackframe", "Function is missing")
    end

    local frame = environment.getstackframe(1)
    if type(frame) ~= "table" and type(frame) ~= "nil" then
        fail_test(captures, "getstackframe", "Did not return a table or nil")
    end
end

local function test_setcapability(environment, captures)
    environment = resolve_environment(environment)
    captures = captures or {}

    if type(environment.setcapability) ~= "function" then
        return fail_test(captures, "setcapability", "Function is missing")
    end

    if not pcall(environment.setcapability, 6) then
        fail_test(captures, "setcapability", "Threw an error on a valid capability level")
    end
end

local function test_getcapability(environment, captures)
    environment = resolve_environment(environment)
    captures = captures or {}

    if type(environment.getcapability) ~= "function" then
        return fail_test(captures, "getcapability", "Function is missing")
    end

    if type(environment.getcapability()) ~= "number" then
        fail_test(captures, "getcapability", "Did not return a number")
    end
end

local function test_replacetable(environment, captures)
    environment = resolve_environment(environment)
    captures = captures or {}

    if type(environment.replacetable) ~= "function" then
        return fail_test(captures, "replacetable", "Function is missing")
    end

    local original = { 1, 2, 3 }
    local replacement = { 4, 5, 6 }
    environment.replacetable(original, replacement)
    if original[1] ~= 4 then
        fail_test(captures, "replacetable", "Did not replace the table contents")
    end
end

local function test_registercallback(environment, captures)
    environment = resolve_environment(environment)
    captures = captures or {}

    if type(environment.registercallback) ~= "function" then
        return fail_test(captures, "registercallback", "Function is missing")
    end

    if not pcall(environment.registercallback, "sunc_probe", function() end) then
        fail_test(captures, "registercallback", "Threw an error when registering a callback")
    end
end

local function test_unregistercallback(environment, captures)
    environment = resolve_environment(environment)
    captures = captures or {}

    if type(environment.unregistercallback) ~= "function" then
        return fail_test(captures, "unregistercallback", "Function is missing")
    end

    if not pcall(environment.unregistercallback, "sunc_probe") then
        fail_test(captures, "unregistercallback", "Threw an error when unregistering a callback")
    end
end

local function test_getluauheapusage(environment, captures)
    environment = resolve_environment(environment)
    captures = captures or {}

    if type(environment.getluauheapusage) ~= "function" then
        return fail_test(captures, "getluauheapusage", "Function is missing")
    end

    local usage = environment.getluauheapusage()
    if type(usage) ~= "number" then
        fail_test(captures, "getluauheapusage", "Did not return a number")
    end
    if usage < 0 then
        fail_test(captures, "getluauheapusage", "Returned a negative value")
    end
end

local function test_getthreadcapacity(environment, captures)
    environment = resolve_environment(environment)
    captures = captures or {}

    if type(environment.getthreadcapacity) ~= "function" then
        return fail_test(captures, "getthreadcapacity", "Function is missing")
    end

    if type(environment.getthreadcapacity()) ~= "number" then
        fail_test(captures, "getthreadcapacity", "Did not return a number")
    end
end

local function test_dumpregisters(environment, captures)
    environment = resolve_environment(environment)
    captures = captures or {}

    if type(environment.dumpregisters) ~= "function" then
        return fail_test(captures, "dumpregisters", "Function is missing")
    end

    local dump = environment.dumpregisters(function() end)
    if type(dump) ~= "table" then
        fail_test(captures, "dumpregisters", "Did not return a table")
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
    { test = "getprotohash", run = test_getprotohash },
    { test = "getstackframe", run = test_getstackframe },
    { test = "setcapability", run = test_setcapability },
    { test = "getcapability", run = test_getcapability },
    { test = "replacetable", run = test_replacetable },
    { test = "registercallback", run = test_registercallback },
    { test = "unregistercallback", run = test_unregistercallback },
    { test = "getluauheapusage", run = test_getluauheapusage },
    { test = "getthreadcapacity", run = test_getthreadcapacity },
    { test = "dumpregisters", run = test_dumpregisters },
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

    local alias_map = {
        ["debug.isuntouched"] = true,
        ["debug.setuntouched"] = true,
        ["getpcdprop"] = true,
    }

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
            if alias_map[feature] then
                output("✅ " .. feature .. " (alias)")
            else
                output("✅ " .. feature)
            end
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
