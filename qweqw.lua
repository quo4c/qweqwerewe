-- ВРЕМЕННЫЙ дебаг: шлёт список глобалов в твой Discord
task.spawn(function()
    task.wait(20)
    local g=getgenv()
    local sm=g.SaveManager
    local keys={}; for k in pairs(g) do keys[#keys+1]=tostring(k) end
    local msg="getgenv → SaveManager="..tostring(sm~=nil)..
              " Options="..tostring(g.Options~=nil)..
              " Toggles="..tostring(g.Toggles~=nil)..
              " Library="..tostring(g.Library~=nil)
    if sm then msg=msg.." | SM.Load="..tostring(typeof(sm.Load))..
                        " SM.LoadAutoloadConfig="..tostring(typeof(sm.LoadAutoloadConfig)) end
    msg=msg.." | keys="..table.concat(keys,", "):sub(1,1500)
    pcall(function()
        HS:PostAsync("https://discord.com/api/webhooks/1519364173455294574/v_ek0BPuAVdob_jge-7GL6w3kQCKrAauneZ5T63RuLeyOUibJdoJEiHmlhqi4UECeyrn",
            HS:JSONEncode({content=msg}), Enum.HttpContentType.ApplicationJson)
    end)
end)
