--[[
    Main (Script)
    Path: ServerScriptService
    Parent: ServerScriptService
    Properties:
        Disabled: false
    Exported: 2026-08-03 19:31:17 (web)
]]

local GameManagerModule = require(script.GameManager)
local TeamsService = game:GetService("Teams")
local RoundsModule = require(script.RoundSystem)

game.Players.PlayerAdded:Connect(function(Player)
	Player.Team = TeamsService.Spectator
	if GameManagerModule.MakeTeams(Player) then
		game.ReplicatedStorage.Remotes.Initiate:FireAllClients()
		print("true and fired")
	end
end)

game.ReplicatedStorage:WaitForChild("Remotes").Round.OnServerEvent:Connect(function(Player, RoundNo)
	if RoundNo == 1 then
		coroutine.resume(coroutine.create(function()

			RoundsModule.Round(Player)
		end))
		
		coroutine.resume(coroutine.create(function()
			while true do
				task.wait()
				GameManagerModule.UpdatePointsDisplay(Player)
			end
		end))
	end
end)