--[[
    Tutorial (Script)
    Path: ServerScriptService
    Parent: ServerScriptService
    Properties:
        Disabled: false
    Exported: 2026-07-30 17:49:26 (web)
]]

local TutorialUIModule = require(script.TutorialUI)
local TutorialManagerModule = require(script.TutorialManager)

game.Players.PlayerAdded:Connect(function(player)
	TutorialUIModule.ShowUI(player)
	player.PlayerGui.Main.TutorialFrame.Next.MouseButton1Up:Connect(function()
		TutorialUIModule.Next()
	end)
end)