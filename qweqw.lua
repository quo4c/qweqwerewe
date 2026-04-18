_G.MY_KEY_IS = "otNlKfSQpcMkrcLRObcsSXSJgZGJmVIk"

local count = 0

local old_loadstring = hookfunction(loadstring, function(code, ...)
    count = count + 1
    local name = "hh_ls_" .. count .. ".lua"
    pcall(writefile, name, tostring(code))
    warn("[LS] " .. name .. " | " .. #tostring(code))
    return old_loadstring(code, ...)
end)

local old_load = hookfunction(load, function(code, ...)
    count = count + 1
    local name = "hh_load_" .. count .. ".lua"
    pcall(writefile, name, tostring(code))
    warn("[LOAD] " .. name .. " | " .. #tostring(code))
    return old_load(code, ...)
end)

local old_http = hookfunction(game.HttpGet, function(self, url, ...)
    count = count + 1
    local result = old_http(self, url, ...)
    local name = "hh_http_" .. count .. ".txt"
    pcall(writefile, name, "-- " .. tostring(url) .. "\n\n" .. tostring(result))
    warn("[HTTP] " .. tostring(url) .. " | " .. #tostring(result))
    return result
end)

loadstring(game:HttpGet('https://raw.githubusercontent.com/acsu123/HohoV2/refs/heads/main/ScriptLoad.lua'))()
