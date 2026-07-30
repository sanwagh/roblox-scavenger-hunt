--[[
    ServerMatchmaking (ModuleScript)
    Path: ServerScriptService → MatchmakingManager
    Parent: MatchmakingManager
    Properties:
        Disabled: false
    Exported: 2026-07-30 17:48:10 (web)
]]

local Matchmaking = {}

local TeleportService = game:GetService("TeleportService")

function Matchmaking.SearchQueue(Mode, Player, MaxPlayers)
	local Queue = #game.ServerStorage.Queue:GetChildren()
	print(Queue)
	
	if Queue == 0 then
		Matchmaking.CreateQueue(Mode,Player,MaxPlayers) --Create a queue if there are none in the folder
	elseif Queue > 0 then
		for i, queues in ipairs(game.ServerStorage.Queue:GetChildren()) do
			if queues.Name ~= Mode then
				Matchmaking.CreateQueue(Mode,Player,MaxPlayers)
			end
			if #queues:GetChildren() < MaxPlayers and queues.Name == Mode then
				print("Empty space available")
				Matchmaking.AddToQueue(Mode,Player,queues, MaxPlayers)
				-- ui stuff
			elseif #queues:GetChildren() >= MaxPlayers then
				Matchmaking.TeleportGroup(Mode, queues)	
				Player.PlayerGui.Main.QueueFrame.PlayersInQueue.Text = "Teleporting to server..."
			else
				warn("Error: Queue Overflow! Aborting Matchmaking for current players in the queue")
			end
		end	
	end
end

function Matchmaking.CreateQueue(Mode, Player,MaxPlayers)
	print("[Matchmaking]: No Queue found! Creating New queue")	
	local QueueFolder = Instance.new("Folder")
	QueueFolder.Name = Mode
	QueueFolder.Parent = game.ServerStorage.Queue
	
	Matchmaking.AddToQueue(Mode,Player,QueueFolder,MaxPlayers)
end

function Matchmaking.AddToQueue(Mode, Player, QueueFolder,MaxPlayers)
	print("[Matchmaking]: Found Queue. Adding Player")
	local PlayerInstance = Instance.new("StringValue")
	PlayerInstance.Value = Player.Name
	PlayerInstance.Parent = QueueFolder
	
	if #QueueFolder:GetChildren() >= MaxPlayers then
		Matchmaking.TeleportGroup(Mode,QueueFolder)
		Player.PlayerGui.Main.QueueFrame.PlayersInQueue.Text = "Teleporting to server..."
	end
	
	Player.QueueName.Value = Mode
	Player.InQueue.Value = true
end

function Matchmaking.TeleportGroup(Mode, QueueFolder)
	local PlayerTable = {}
	print("[Matchmaking]: Preparing player group for teleport")
	
	for i,players in pairs(QueueFolder:GetChildren()) do
		local player = game.Players:FindFirstChild(players.Value)
		
		
		game.ServerStorage.PlayerInfo[player.Name].LastLogin.Value = os.date()
		
		table.insert(PlayerTable,player)
	end
	print("[Matchmaking]: Teleporting Player Group")
	
	local PvtId = TeleportService:ReserveServer(GetGameModeId(Mode))
	QueueFolder:Destroy()
	TeleportService:TeleportToPrivateServer(GetGameModeId(Mode), PvtId, PlayerTable,nil,Mode,game.StarterGui.TeleportGui)
end

function Matchmaking.LeaveQueue(Player)
	local PlayerQueue = SearchPlayer(Player)
	PlayerQueue:Destroy()
	
	local MatchmakingUIModule = require(script.Parent.MatchmakingUI)
	MatchmakingUIModule.HideQueueUI(Player)
	
	Player.InQueue.Value = false
	Player.QueueName.Value = ""
	
	Player.PlayerGui.Main.Play.Visible = true
	
	coroutine.resume(coroutine.create(function()
		SearchEmptyQueue()
	end))
	
	print("[Matchmaking]: Player "..Player.Name.." has been removed from the queue")
end

function GetGameModeId(Mode)
		return 13400780108
end

function SearchEmptyQueue()
	while true do
		wait()
		for i,v in pairs(game.ServerStorage.Queue:GetChildren()) do
			if #v:GetChildren() == 0 then
				v:Destroy()
			end
		end
	end
end


function SearchPlayer(Player)
	for i,v in pairs(game.ServerStorage.Queue:GetDescendants()) do
		if v:IsA("StringValue") then
			if v.Value == Player.Name then
				print("[Matchmaking]: Found Player. Removing from queue")
			return v
			end
		end
	end
end

return Matchmaking
