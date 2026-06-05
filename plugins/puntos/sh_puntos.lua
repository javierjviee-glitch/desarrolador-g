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

if CLIENT then
    net.Receive("AbrirMenuPuntos", function()
        local puntos = net.ReadTable()

        local frame = vgui.Create("DFrame")
        frame:SetSize(300, 400)
        frame:Center()
        frame:SetTitle("Puntos de las Casas")
        frame:MakePopup()

        local casas = {
            {nombre = "Gryffindor", color = Color(200, 0, 0)},
            {nombre = "Slytherin", color = Color(0, 150, 0)},
            {nombre = "Ravenclaw", color = Color(0, 100, 200)},
            {nombre = "Hufflepuff", color = Color(200, 200, 0)}
        }

        for _, casa in ipairs(casas) do
            local panel = vgui.Create("DPanel", frame)
            panel:Dock(TOP)
            panel:SetTall(50)

            panel.Paint = function(self, w, h)
                draw.RoundedBox(4, 0, 0, w, h, casa.color)
                draw.SimpleText(casa.nombre .. ": " .. puntos[casa.nombre], "DermaLarge", 10, 10, color_white)
            end
             local add = vgui.Create("DButton", panel)
            add:Dock(RIGHT)
            add:SetText("+")
            add.DoClick = function()
                net.Start("ActualizarPuntos")
                net.WriteString(casa.nombre)
                net.WriteInt(1, 16)
                net.SendToServer()
            end

            local sub = vgui.Create("DButton", panel)
            sub:Dock(RIGHT)
            sub:SetText("-")
            sub.DoClick = function()
                net.Start("ActualizarPuntos")
                net.WriteString(casa.nombre)
                net.WriteInt(-1, 16)
                net.SendToServer()
            end
        end
    end)
end