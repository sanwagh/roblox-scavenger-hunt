--[[
    Staging (ModuleScript)
    Path: ServerScriptService → MatchmakingManager
    Parent: MatchmakingManager
    Properties:
        Disabled: false
    Exported: 2026-07-30 17:48:10 (web)
]]

local Staging = {}

local TeleportService = game:GetService("TeleportService")

function Staging.Authorisation(Player:Player)
	if Player.UserId == game.CreatorId then
		Player.PlayerGui:WaitForChild("Main").GameModes.Testing.Visible = true
	else
		Player.PlayerGui:WaitForChild("Main").GameModes.Testing.Visible = false
		warn("[Staging] - Check 2: Player is not an admin. Check 1 - PASSED")
	end
end

function Staging.Teleport(Player:Player)
	local PlayerTable = {Player}
	TeleportService:TeleportAsync(13400780108, PlayerTable)
end

return Staging
