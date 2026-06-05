include("shared.lua")

net.Receive("SombreroSeleccionado", function()
    local casa = net.ReadString()
    chat.AddText(Color(255, 215, 0), "[Sombrero] ", color_white, "mmmh interesante, su casa sera: ", Color(150, 150, 255), casa)
end)
