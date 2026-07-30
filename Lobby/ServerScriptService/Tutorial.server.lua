--[[
    Tutorial (Script)
    Path: ServerScriptService
    Parent: ServerScriptService
    Properties:
        Disabled: false
    Exported: 2026-07-30 17:48:10 (web)
]]

local TutorialModule = require(script.Teleport)

game.Workspace:WaitForChild("Tutorial").UpperTorso.ProximityPrompt.Triggered:Connect(function(player)
	TutorialModule.TeleportPlayer(player)
end)