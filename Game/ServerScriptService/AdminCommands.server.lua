--[[
    AdminCommands (Script)
    Path: ServerScriptService
    Parent: ServerScriptService
    Properties:
        Disabled: false
    Exported: 2026-08-03 19:31:17 (web)
]]

local Commands = {}

local Admins = {
	"Newsletterfarm";
	"Player1"
}

local Prefix = "/"

local ChatService = game:GetService("TextChatService")

local function FindPlayer(name)
	for i, plr in pairs(game.Players:GetPlayers()) do
		if string.lower(plr.Name) == name then
			return plr --returns obj
		end
	end
	
	return nil
end


local function PlayerIsAdmin(player)
	for _,v in pairs(Admins) do
		if v == player.Name then
			return true
		end
	end
	
	return false
end

Commands.teleport = function(Sender, Arguments)
	for i,PlayerName in pairs(Arguments) do
		print(PlayerName)
	end
	
	local PlayerToTeleportName = Arguments[1]
	local PlayerToTeleportToName = Arguments[2]
	
	if PlayerToTeleportName and PlayerToTeleportToName then
		local plrToTp = FindPlayer(PlayerToTeleportName)
		local plrToTpTo = FindPlayer(PlayerToTeleportToName)
		
		if plrToTp and plrToTpTo then
			plrToTp.Character.HumanoidRootPart.CFrame = plrToTpTo.Character.HumanoidRootPart.CFrame
		end
	end
end



Commands.speed = function(Sender, Arguments)
	local Player = Arguments[1]
	local SpeedAmt = Arguments[2]
	
	if Player then
		local plr = FindPlayer(Player)
		if plr then
			plr.Character.Humanoid.WalkSpeed = tonumber(SpeedAmt)
		end
	end
end

Commands.kill = function(Sender,Arguments)
	local Player = Arguments[1]
	local PlayerToKill = Arguments[2]
	
	if Player and PlayerToKill then
		local plr = FindPlayer(Player)
		local PlrToKill = FindPlayer(PlayerToKill)
		
		if plr and PlrToKill then
			PlrToKill.Character.Humanoid.Health = 0
		end
	end
end

Commands.set_health = function(Sender, Arguments)
	local Player = Arguments[1]
	local Health = Arguments[2]

	if Player then
		local Plr = FindPlayer(Player)
		
		if not Health then
			warn("[AC Cmd] Set a valid player health.")
		end
		if Plr then
			Plr.Character.Humanoid.Health = Health
		end
	end
end

game.Players.PlayerAdded:Connect(function(player)
	player.Chatted:Connect(function(Message, Recipient)
		if PlayerIsAdmin(player) then
			Message = string.lower(Message)

			local SplitString = Message:split(" ")
			local SlashCommand = SplitString[1]

			local Cmd = SlashCommand:split(Prefix)
			local CmdName = Cmd[2]

			if Commands[CmdName] then

				local Args = {}

				for i = 2, #SplitString,1 do
					table.insert(Args,SplitString[i])
				end

				Commands[CmdName](player,Args) --Calling a function from the Commands table
			end
		else
			print("[Admin Cmd] Player is not an admin.")	
		end
	end)
end)