--[[
    Access (Script)
    Path: ServerScriptService → MatchmakingManager → Staging
    Parent: Staging
    Properties:
        Disabled: false
    Exported: 2026-07-30 17:48:10 (web)
]]

local TestingModule = require(script.Parent)

game.Players.PlayerAdded:Connect(function(Player)
	if Player.UserId == game.CreatorId then
		TestingModule.Authorisation(Player)
	else
		print("[Staging]: Player is not an admin.")
	end
	Player.PlayerGui:WaitForChild("Main").GameModes.Testing.MouseButton1Up:Connect(function()
		TestingModule.Teleport(Player)
	end)
end)