if SERVER then
    util.AddNetworkString("AbrirMenuPuntos")
    util.AddNetworkString("ActualizarPuntos")

    PLUGIN.puntos = {
        Gryffindor = 0,
        Slytherin = 0,
        Ravenclaw = 0,
        Hufflepuff = 0
    }

    net.Receive("ActualizarPuntos", function(_, ply)
        if not ix.config.Get("permitirModificarPuntos", true) then return end

        local casa = net.ReadString()
        local cantidad = net.ReadInt(16)

        PLUGIN.puntos[casa] = math.max(0, PLUGIN.puntos[casa] + cantidad)
    end)

    concommand.Add("abrir_puntos", function(ply)
        net.Start("AbrirMenuPuntos")
        net.WriteTable(PLUGIN.puntos)
        net.Send(ply)
    end)
end