--[[
    AntiCheat (ModuleScript)
    Path: ServerScriptService → AntiCheatEngine
    Parent: AntiCheatEngine
    Properties:
        Disabled: false
    Exported: 2026-08-03 19:31:17 (web)
]]

local AntiCheat = {}
local AC_Flags = require(game.ServerScriptService:WaitForChild("AntiCheatEngine").WebhookService.AC_Flags)
local flagged = false

local Flags = 0
local Whitelist = {"Newsletterfarm"}

local wsDetect = 16

function AntiCheat.CheckAntiCheat(player)
	if (script.Parent:FindFirstChild("BanDataStore")) ~= nil then
		return 
	else
		if not flagged then
			flagged = true
			warn("[AntiCheat]: Modules not found. Kicking Player")
			game.ServerStorage.AntiCheatData:WaitForChild(player.Name).Flags.Value += 1
			AC_Flags.SendFlagData(player, "AntiCheat modules were not found/deleted")
			player:Kick("AntiCheatEngine: Anti Cheat not found/deleted.")
			return false
		end
	end
end

function AntiCheat.CheckHumanoidProperties(Player)
	print("[AntiCheat]: Initialized Main Module")
	local Chr = Player.CharacterAdded:Wait()
	--//Main
	coroutine.resume(coroutine.create(function()
		--//Vars
		wait(5)
		local Hum = Chr:WaitForChild("Humanoid")
		local Root = Chr:WaitForChild("HumanoidRootPart")
		--
		if not Hum or not Root then return end

		--//Logic Vars
		local lastSpeedChange = 0
		local LastCFrame = Root.CFrame

		--//Hooks
		Hum:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
			lastSpeedChange = tick()
		end)

		--//Function
		local function Check()
			local ThisPosition = Vector3.new(Root.Position.X,0,Root.Position.Z)
			local LastPosition = Vector3.new(LastCFrame.Position.X,0,LastCFrame.Position.Z)
			local Distance = (ThisPosition - LastPosition).Magnitude
			
			local WalkSpeed = Hum.WalkSpeed
			
			if Distance > (WalkSpeed + wsDetect) and not table.find(Whitelist, game.Players:GetPlayerFromCharacter(Chr).UserId) then
				if Flags >= 5 then
					AC_Flags.SendFlagData(Player, "Sppeding/Teleporting")
					game.Players:GetPlayerFromCharacter(Chr):Kick("Anti Cheat: Speed/Teleporting Detected")
					
					local Msg = "Anti Cheat: " .. game.Players:GetPlayerFromCharacter(Chr).Name .. " Was Kicked For Cheating"

					local player = game.Players:GetPlayerFromCharacter(Chr)
					local Reason = "Speed/Teleporting"

				else
					if not table.find(Whitelist, game.Players:GetPlayerFromCharacter(Chr).UserId)  then
						Root.CFrame = LastCFrame
						print(LastCFrame)
						print("tp to last")
						Flags += 1 
					end

				end

			end
		end
		while true do
			LastCFrame = Root.CFrame
			wait(1)
			if tick() - lastSpeedChange >= 1 then
				Check()
			end
		end

	end))
	Chr.Humanoid.StateChanged:Connect(function(old, new)
		if new == Enum.HumanoidStateType.StrafingNoPhysics and not table.find(Whitelist, Player.UserId) then
			AC_Flags.SendFlagData(Player, "NoClip")
			Player:Kick("Anti Cheat: Noclip Detected")
		end
	end)
end

return AntiCheat
