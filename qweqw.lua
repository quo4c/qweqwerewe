_G.MY_KEY_IS = "otNlKfSQpcMkrcLRObcsSXSJgZGJmVIk"

local _count = 0
local _orig_ls = loadstring
local notify = function(title, text)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = title,
            Text = text
        })
    end)
end

-- перехват loadstring
loadstring = function(code, ...)
    _count = _count + 1
    pcall(writefile, "dump_" .. _count .. ".lua", tostring(code))
    notify("DUMP " .. _count, #tostring(code) .. " bytes")
    return _orig_ls(code, ...)
end

-- перехват HTTP
local _orig_http = game.HttpGet
game.HttpGet = function(self, url, ...)
    _count = _count + 1
    local result = _orig_http(self, url, ...)
    pcall(writefile, "http_" .. _count .. ".txt",
        "-- URL: " .. tostring(url) .. "\n\n" .. tostring(result))
    notify("HTTP " .. _count, tostring(url):sub(1, 40))
    return result
end

-- запуск
loadstring(game:HttpGet("https://raw.githubusercontent.com/acsu123/HOHO_H/main/Loading_UI"))()
