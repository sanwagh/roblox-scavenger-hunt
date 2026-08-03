--[[
    PlayerData (ModuleScript)
    Path: ServerScriptService → DataStores
    Parent: DataStores
    Properties:
        Disabled: false
    Exported: 2026-08-03 19:31:17 (web)
]]

local DataStore = {}

local DataStoreService = game:GetService("DataStoreService")
local PlayerDataStore = DataStoreService:GetDataStore("PlayerDataStoreAlpha")
local BindableEvent = Instance.new("BindableEvent")
local PlayersLeft = 0

function DataStore.CreateData(Player:Player)
	local PlayerData = Instance.new("Folder")
	PlayerData.Name = Player.Name
	PlayerData.Parent = game.ServerStorage.PlayerData
	
	local Wins = Instance.new("IntValue")
	Wins.Name = "Wins"
	Wins.Parent = PlayerData
	
	local Points = Instance.new("IntValue")
	Points.Name = "Points"
	Points.Parent = PlayerData
	
	local DataLoaded = Instance.new("BoolValue")
	DataLoaded.Name = "DataLoaded"
	DataLoaded.Parent = Player
	
	local BluePoints = Instance.new("IntValue")
	BluePoints.Name = "BluePoints"
	BluePoints.Parent = game.ServerStorage.ServerData
	
	local RedPoints = Instance.new("IntValue")
	RedPoints.Name = "RedPoints"
	RedPoints.Parent = game.ServerStorage.ServerData
	
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
	local PlayerData = game.ServerStorage.PlayerData[Player.Name]
	
	if success then
		PlayerData.Wins.Value = Data.Wins
		PlayerData.Points.Value = Data.Points
		print("[DataStore] - PlayerData: Loaded Data")
	else
		print(errormessage)
	end
	return true
end

function DataStore.SaveData(Player:Player)
	local Key = "Data:"..Player.UserId
	local PlayerData = game.ServerStorage.PlayerData[Player.Name]
	
	Data = {
		Wins = PlayerData.Wins.Value;
		Points = PlayerData.Points.Value
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
