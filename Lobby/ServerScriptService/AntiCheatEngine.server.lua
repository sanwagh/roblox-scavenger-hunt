--[[
    AntiCheatEngine (Script)
    Path: ServerScriptService
    Parent: ServerScriptService
    Properties:
        Disabled: false
    Exported: 2026-07-30 17:48:10 (web)
]]

local AntiCheatModule = require(script.AntiCheat)
local BanDataModule = require(script.BanDataStore)
local RunService = game:GetService("RunService")

game.Players.PlayerAdded:Connect(function(player)
	BanDataModule.new()
	BanDataModule:CreateData(player)
	BanDataModule:LoadData(player)

	coroutine.resume(coroutine.create(function()
		AntiCheatModule.CheckHumanoidProperties(player)
	end))

	coroutine.resume(coroutine.create(function()
		while true do
			wait(0.5)
			coroutine.resume(coroutine.create(function()
				if AntiCheatModule.CheckAntiCheat(player) then else return end

				return
			end))
		end		
	end))
end)

game.Players.PlayerRemoving:Connect(function(Player)
	BanDataModule:SaveData(Player)
end)