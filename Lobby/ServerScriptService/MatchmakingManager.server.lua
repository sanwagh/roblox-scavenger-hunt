--[[
    MatchmakingManager (Script)
    Path: ServerScriptService
    Parent: ServerScriptService
    Properties:
        Disabled: false
    Exported: 2026-07-30 17:48:10 (web)
]]

local MatchmakingModule = require(script.ServerMatchmaking)
local MatchmakingUIModule = require(script.MatchmakingUI)

game.ReplicatedStorage:WaitForChild("Remotes").AddQueue.OnServerEvent:Connect(function(player, Mode)
	print("[Matchmaking]: Searching for a queue...")
	local MaxPlayers = game.ServerStorage.GameModeInfo:FindFirstChild(Mode).Value
	
	MatchmakingModule.SearchQueue(Mode,player, MaxPlayers)
	MatchmakingUIModule.ShowQueueUI(player, MaxPlayers, Mode)
	
	player.PlayerGui.Main.QueueFrame.Exit.MouseButton1Up:Connect(function()
		MatchmakingModule.LeaveQueue(player)
	end)
end)