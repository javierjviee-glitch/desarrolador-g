local PLUGIN = PLUGIN

function PLUGIN:PlayerLoadedCharacter(client, character)
    timer.Simple(1, function()
        if not IsValid(client) then return end

        local money = character:GetMoney()
        client:Notify(
            "Buenos días " .. character:GetName() .. ". Tienes " .. money .. " créditos."
        )
    end)
end

