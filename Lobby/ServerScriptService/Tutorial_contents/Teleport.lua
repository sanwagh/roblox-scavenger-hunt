--[[
    Teleport (ModuleScript)
    Path: ServerScriptService → Tutorial
    Parent: Tutorial
    Properties:
        Disabled: false
    Exported: 2026-07-30 17:48:10 (web)
]]

local Teleport = {}

local TeleportService = game:GetService("TeleportService")

function Teleport.TeleportPlayer(Player:Player)
	local Id = 13839166899
	local Server = TeleportService:ReserveServer(Id)
	local PlayerTable = {Player}
	
	TeleportService:TeleportToPrivateServer(Id,Server,PlayerTable)
end

return Teleport
