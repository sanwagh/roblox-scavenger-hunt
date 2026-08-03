--[[
    BanDataStore (ModuleScript)
    Path: ServerScriptService → AntiCheatEngine
    Parent: AntiCheatEngine
    Properties:
        Disabled: false
    Exported: 2026-08-03 19:31:17 (web)
]]

local DataStore = {}
DataStore.__index = DataStore

local DataStoreService = game:GetService("DataStoreService")
local BanDataStore = DataStoreService:GetDataStore("BanDataStore")
local BindableEvent = Instance.new("BindableEvent")
local PlayersLeft = 0

function DataStore.new()
	return setmetatable({},DataStore)
end

function DataStore:CreateData(Player: Player)
	local PlayerData = Instance.new("Folder")
	PlayerData.Parent = game.ServerStorage.AntiCheatData
	PlayerData.Name = Player.Name

	local Flags = Instance.new("IntValue")
	Flags.Name = "Flags"
	Flags.Parent = PlayerData

	local Kicks = Instance.new("IntValue")
	Kicks.Name = "Kicks"
	Kicks.Parent = PlayerData

	local PlayerBanned = Instance.new("BoolValue")
	PlayerBanned.Name = "PlayerBanned"
	PlayerBanned.Parent = PlayerData

	local BanReason = Instance.new("StringValue")
	BanReason.Name = "BanReason"
	BanReason.Parent = PlayerData
end

function DataStore:LoadData(Player: Player)
	PlayersLeft += 1
	local Key = "BanData:"..Player.UserId
	local Data = {}

	local success, errormessage = pcall(function()
		Data = BanDataStore:GetAsync(Key)
	end)
	local PlayerFolder = game.ServerStorage.AntiCheatData[Player.Name]
	print(Data)
	if success then
		local StartTime = os.time()
		print("[BanDataStore] Loading Player Data...")
		PlayerFolder.Flags.Value = Data.Flags
		PlayerFolder.Kicks.Value = Data.Kicks 
		PlayerFolder.PlayerBanned.Value = Data.PlayerBanned
		PlayerFolder.BanReason.Value = Data.BanReason
		local EndTime = os.time()

		print("[BanDataStore]: Loaded player data in "..EndTime - StartTime.." seconds")
	end
end

function DataStore:SaveData(Player:Player)
	local Key = "BanData:"..Player.UserId
	local PlayerFolder = game.ServerStorage.AntiCheatData[Player.Name]

	local Data = {
		Flags = PlayerFolder.Flags.Value;
		Kicks = PlayerFolder.Kicks.Value;
		PlayerBanned = PlayerFolder.PlayerBanned.Value;
		BanReason = PlayerFolder.BanReason.Value;
	}

	local success, errormessage = pcall(function()
		Data = BanDataStore:SetAsync(Key,Data)
	end)

	if success then
		print("[BanDataStore]: Saved player Ban Data")
		PlayersLeft -= 1
		BindableEvent:Fire()
	end
	game:BindToClose(function()
		while PlayersLeft > 0 do
			BindableEvent.Event:Wait()
		end
	end)
end


return DataStore
