local PLUGIN = PLUGIN


function PLUGIN:PlayerInitialSpawn(client)
    timer.Simple(1, function()
        if not IsValid(client) then return end
        
        local name = client:Name()

        for _, v in ipairs(player.GetAll()) do
            v:ChatPrint(" El jugador " .. name .. " se ha unido al servidor.")
        end
    end)
end