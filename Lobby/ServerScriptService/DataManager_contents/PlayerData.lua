--[[
    PlayerData (ModuleScript)
    Path: ServerScriptService → DataManager
    Parent: DataManager
    Properties:
        Disabled: false
    Exported: 2026-07-30 17:48:10 (web)
]]

local DataStore = {}

local DataStoreService = game:GetService("DataStoreService")
local PlayerDataStore = DataStoreService:GetDataStore("PlayerDataStoreAlpha")
local BindableEvent = Instance.new("BindableEvent")
local PlayersLeft = 0

function DataStore.CreateData(Player:Player)
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = Player
	
	local Wins = Instance.new("IntValue")
	Wins.Name = "Wins"
	Wins.Parent = leaderstats
	
	local Points = Instance.new("IntValue")
	Points.Name = "Points"
	Points.Parent = leaderstats
	
	local DataLoaded = Instance.new("BoolValue")
	DataLoaded.Name = "DataLoaded"
	DataLoaded.Parent = Player
	
	local QueueName = Instance.new("StringValue")
	QueueName.Name = "QueueName"
	QueueName.Parent = Player
	
	local InQueue = Instance.new("BoolValue")
	InQueue.Name = "InQueue"
	InQueue.Parent = Player
	
	return true
end

function DataStore.LoadData(Player:Player)
	local Key = "Data:"..Player.UserId
	PlayersLeft += 1
	
	local Data
	
	local success, errormessage = pcall(function()
		Data = PlayerDataStore:GetAsync(Key)
		Player.DataLoaded.Value = true
		print("[DataStore] - PlayerData: Loading Data")
	end)
	
	if Data == nil then Data = {} end
	
	if success then
		Player.leaderstats.Wins.Value = Data.Wins
		Player.leaderstats.Points.Value = Data.Points
		print("[DataStore] - PlayerData: Loaded Data")
	else
		print(errormessage)
	end
	return true
end

function DataStore.SaveData(Player:Player)
	local Key = "Data:"..Player.UserId
	
	Data = {
		Wins = Player.leaderstats.Wins.Value;
		Points = Player.leaderstats.Points.Value
	}
	
	local success, errormessage = pcall(function()
		if Player.DataLoaded.Value == true then
			Data = PlayerDataStore:SetAsync(Key,Data)
			print("[DataStore] - PlayerData: Saving Data")
		else
			warn("[DataStore] - PlayerData: Did not save data. Data was not loaded")
		end
	end)
	
	PlayersLeft -= 1
	BindableEvent:Fire()
	
	if success then
		print("[DataStore] - PlayerData: Saved Data")
	else
		print(errormessage)
	end
	
	game:BindToClose(function()
		while PlayersLeft > 0  do
			BindableEvent.Event:Wait()
		end
	end)
	return true
end

return DataStore
