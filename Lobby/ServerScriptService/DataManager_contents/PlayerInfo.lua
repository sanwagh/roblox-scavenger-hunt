--[[
    PlayerInfo (ModuleScript)
    Path: ServerScriptService → DataManager
    Parent: DataManager
    Properties:
        Disabled: false
    Exported: 2026-07-30 17:48:10 (web)
]]

local DataStore = {}
local DataStoreService = game:GetService("DataStoreService")
local PlayerInfo = DataStoreService:GetDataStore("PlayerInfo")
local BindableEvent = Instance.new("BindableEvent")
local PlayersLeft = 0

function DataStore.CreateData(Player:Player)
	local PlayerFolder = Instance.new("Folder")
	PlayerFolder.Name = Player.Name
	PlayerFolder.Parent = game.ServerStorage.PlayerInfo
	
	local Joins = Instance.new("IntValue")
	Joins.Name = "Joins"
	Joins.Parent = PlayerFolder
	
	local Kicks = Instance.new("IntValue")
	Kicks.Name = "Kicks"
	Kicks.Parent = PlayerFolder
	
	local LastJoin = Instance.new("StringValue")
	LastJoin.Name = "LastJoin"
	LastJoin.Parent = PlayerFolder
	
	local LastLogin = Instance.new("StringValue")
	LastLogin.Name = "LastLogin"
	LastLogin.Parent = PlayerFolder
	
	local TotalPoins = Instance.new("IntValue")
	TotalPoins.Name = "TotalPoints"
	TotalPoins.Parent = PlayerFolder
	
	local TotalWins = Instance.new("IntValue")
	TotalWins.Name = "TotalWins"
	TotalWins.Parent = PlayerFolder
	
	local TotalLost = Instance.new("IntValue")
	TotalLost.Name = "TotalLost"
	TotalLost.Parent = PlayerFolder
	
	local FirstPlay = Instance.new("StringValue")
	FirstPlay.Name = "FirstPlay"
	FirstPlay.Parent = PlayerFolder
	
	local TimePlayed = Instance.new("IntValue")
	TimePlayed.Name = "TimePlayed"
	TimePlayed.Parent = PlayerFolder
	
	return true
end

function DataStore.LoadData(Player:Player)
	PlayersLeft += 1
	local Key = "Info:"..Player.UserId
	local Data
	local StartTime

	local success, errormessage = pcall(function()
		StartTime = os.time()
		Data = PlayerInfo:GetAsync(Key)
		print("[DataStore] - PlayerInfo: Fetching Data")
	end)
	
	if not Data then return true end	
	
	local PlayerFolder = game.ServerStorage.PlayerInfo[Player.Name]
	
	if success then
		
		PlayerFolder.Joins.Value = Data.Joins
		PlayerFolder.Kicks.Value = Data.Kicks
		PlayerFolder.LastJoin.Value = Data.LastJoin
		PlayerFolder.LastLogin.Value = Data.LastLogin
		PlayerFolder.TotalPoints.Value = Data.TotalPoints
		PlayerFolder.TotalWins.Value = Data.TotalWins
		PlayerFolder.TotalLost.Value = Data.TotalLost
		PlayerFolder.FirstPlay.Value = Data.FirstPlay
		
		local EndTime = os.time()
		local TimeElapsed = EndTime - StartTime
		
		print("[DataStore] - PlayerInfo: Loaded Data in "..TimeElapsed)
	end
	return true
end

function DataStore.SaveData(Player:Player)
	local Key = "Info:"..Player.UserId
	local PlayerFolder = game.ServerStorage.PlayerInfo[Player.Name]
	local StartTime
	
	Data = {
		Joins = PlayerFolder.Joins.Value;
		Kicks = PlayerFolder.Kicks.Value;
		LastJoin = PlayerFolder.LastJoin.Value;
		LastLogin = PlayerFolder.LastLogin.Value;
		TotalPoints = PlayerFolder.TotalPoints.Value;
		TotalWins = PlayerFolder.TotalWins.Value;
		TotalLost = PlayerFolder.TotalLost.Value;
		FirstPlay = PlayerFolder.FirstPlay.Value;
		
	}


	local success, errormessage = pcall(function()
		StartTime = os.time()
		Data = PlayerInfo:SetAsync(Key,Data)
		print("[DataStore] - PlayerInfo: Saving Data")
	end)
	
	if success then
		
		local EndTime = os.time()
		local TimeElapsed = EndTime - StartTime
		PlayersLeft -= 1
		BindableEvent:Fire()

		print("[DataStore] - PlayerInfo: Saving Data in "..TimeElapsed.." seconds")
	end
	
	game:BindToClose(function()
		while PlayersLeft >= 0 do
			BindableEvent.Event:Wait()
		end
	end)
	return true
end

return DataStore
