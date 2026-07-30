--[[
    MatchmakingUI (ModuleScript)
    Path: ServerScriptService → MatchmakingManager
    Parent: MatchmakingManager
    Properties:
        Disabled: false
    Exported: 2026-07-30 17:48:10 (web)
]]

local Matchmaking = {}

local Leave = false

function Matchmaking.ShowQueueUI(Player, MaxPlayers,Mode)
	Leave = false
	
	Player.PlayerGui.Main.QueueFrame.Visible = true
	Player.PlayerGui.Main.QueueFrame.QueueName.Text = Mode
	
	coroutine.resume(coroutine.create(function()
		UpdateTimer(Player)
	end))
	
	coroutine.resume(coroutine.create(function()
		UpdatePlayerList(Player,MaxPlayers)
	end))
end

function Matchmaking.HideQueueUI(Player)
	Player.PlayerGui.Main.QueueFrame.Visible = false 	
	Leave = true
end

function UpdateTimer(Player)
	local Timer = 0
	while true do
		Timer += 1
		Player.PlayerGui.Main.QueueFrame.QueueTimer.Text = Timer
		if Leave == true then
			return
		end
		wait(1)
	end
end

function UpdatePlayerList(Player, MaxPlayers)
	local PlayerQueue = SearchPlayer(Player)

	while true do
		wait()
		Player.PlayerGui.Main.QueueFrame.PlayersInQueue.Text = #PlayerQueue:GetChildren().."/"..MaxPlayers.." Players"
		if Leave == true then
			return
		end
	end
end

function SearchPlayer(Player)
	for i,v in ipairs(game.ServerStorage.Queue:GetDescendants()) do
		if v:IsA("StringValue") then
			if v.Value == Player.Name then
				return v.Parent
			end
		end
	end
end

return Matchmaking
