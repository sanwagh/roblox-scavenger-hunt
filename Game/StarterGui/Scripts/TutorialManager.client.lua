--[[
    TutorialManager (LocalScript)
    Path: StarterGui → Scripts
    Parent: Scripts
    Properties:
        Disabled: false
    Exported: 2026-08-03 19:31:17 (web)
]]

local RoundDetailsModule = require(game.ReplicatedStorage:WaitForChild("Modules").Intro.RoundDetails)
local player = game.Players.LocalPlayer

game.ReplicatedStorage:WaitForChild("Remotes").Initiate.OnClientEvent:Connect(function()
	print("Initalizing Game Details for all players")

	RoundDetailsModule.GameDetails(player)
end)