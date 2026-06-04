AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

util.AddNetworkString("SombreroSeleccionado")

local casas = {
    "Gryffindor",
    "Slytherin",
    "Ravenclaw",
    "Hufflepuff"
}
function ENT:Initialize()
    self:SetModel("models/genos/sortinghat.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
end

function ENT:Use(activator)
    if not IsValid(activator) or not activator:IsPlayer() then return end

    local casa = casas[math.random(#casas)]

    net.Start("SombreroSeleccionado")
    net.WriteString(casa)
    net.Send(activator)

    sound.Play("genosrp/" .. string.lower(casa) .. ".wav", self:GetPos(), 75, 100, 1)
end