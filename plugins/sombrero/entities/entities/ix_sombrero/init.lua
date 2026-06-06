AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

local casas = {
    "Gryffindor",
    "Slytherin",
    "Ravenclaw",
    "Hufflepuff"
}

function ENT:Initialize()
    self:SetModel("Steam/steamapps/common/GarrysMod/garrysmod/materials/spawnicons/models/treakdown/choixpeau/tabouret.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
end

function ENT:Use(activator)
    if not IsValid(activator) or not activator:IsPlayer() then return end

    local casa = casas[math.random(#casas)]
    activator:ChatPrint("Has sido elegido para " .. casa)

    sound.Play("genosrp/" .. string.lower(casa) .. ".wav", self:GetPos(), 75, 100, 1)
end
