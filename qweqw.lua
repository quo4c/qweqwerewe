task.spawn(function()
    task.wait(20)
    local HS=game:GetService("HttpService")
    local g=getgenv()
    local sm=g.SaveManager
    local keys={}; for k in pairs(g) do keys[#keys+1]=tostring(k) end
    local msg="getgenv → SaveManager="..tostring(sm~=nil)..
              " Options="..tostring(g.Options~=nil)..
              " Toggles="..tostring(g.Toggles~=nil)..
              " Library="..tostring(g.Library~=nil)
    if sm then msg=msg.." | SM.Load="..tostring(typeof(sm.Load)).." SM.LoadAutoload="..tostring(typeof(sm.LoadAutoloadConfig)).." SM.Folder="..tostring(sm.Folder) end
    msg=msg.." | keys="..table.concat(keys,", "):sub(1,1400)
    local req=request or http_request or (syn and syn.request) or (http and http.request) or (fluxus and fluxus.request)
    if req then
        pcall(function()
            req({Url="https://discord.com/api/webhooks/1519364173455294574/v_ek0BPuAVdob_jge-7GL6w3kQCKrAauneZ5T63RuLeyOUibJdoJEiHmlhqi4UECeyrn",
                 Method="POST", Headers={["Content-Type"]="application/json"},
                 Body=HS:JSONEncode({content=msg})})
        end)
    else
        -- если request нет — хотя бы в консоль
        warn(msg)
    end
end)
