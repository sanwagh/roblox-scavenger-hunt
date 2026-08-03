--[[
    DataStores (Script)
    Path: ServerScriptService
    Parent: ServerScriptService
    Properties:
        Disabled: false
    Exported: 2026-08-03 19:31:17 (web)
]]

local PlayerData = require(script.PlayerData)
game.Players.PlayerAdded:Connect(function(Player)
	if PlayerData.CreateData(Player) then
		PlayerData.LoadData(Player)
	end
end)

game.Players.PlayerRemoving:Connect(function(Player)
	PlayerData.SaveData(Player)
end)