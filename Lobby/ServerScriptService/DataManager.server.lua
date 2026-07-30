--[[
    DataManager (Script)
    Path: ServerScriptService
    Parent: ServerScriptService
    Properties:
        Disabled: false
    Exported: 2026-07-30 17:48:10 (web)
]]

local PlayerInfoModule = require(script.PlayerInfo)
local PlayerDataModule = require(script.PlayerData)
local BindableEvent = Instance.new("BindableEvent")
local PlayersLeft = 0

game.Players.PlayerAdded:Connect(function(Player)
	PlayersLeft += 1
	print("Joined")
	if PlayerInfoModule.CreateData(Player) then
		local PlayerFolder = game.ServerStorage.PlayerInfo[Player.Name]
		PlayerInfoModule.LoadData(Player) 
		PlayerFolder.Joins.Value += 1
		PlayerFolder.LastJoin.Value = os.date()
	end
	if PlayerDataModule.CreateData(Player) then
		if PlayerDataModule.LoadData(Player) then
			
		end
	end
end)

game.Players.PlayerRemoving:Connect(function(Player)
	PlayersLeft -= 1
	BindableEvent:Fire()
	
	if PlayerInfoModule.SaveData(Player) then
		print("[DataStore]: Player left: "..Player.Name)
	end
	
	if PlayerDataModule.SaveData(Player) then
	end
end)