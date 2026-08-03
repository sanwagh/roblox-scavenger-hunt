--[[
    GameManager (ModuleScript)
    Path: ServerScriptService → Main
    Parent: Main
    Properties:
        Disabled: false
    Exported: 2026-08-03 19:31:17 (web)
]]

local GameManager = {}
local TeamsService = game:GetService("Teams")
local TeleportService = game:GetService("TeleportService")
local LobbyId = 13400779039


function GameManager.MakeTeams(Player:Player)
	local Red, Blue = 0,0
	if Red < Blue then
		Player.Team = TeamsService.Red
		Blue += 1
	elseif Red == Blue then
		local Teams = {"Red","Blue"}
		local RandTeam = math.random(1,#Teams)
		local ChosenTeam = Teams[RandTeam]
		
		if ChosenTeam == Blue then
			Blue += 1
		elseif ChosenTeam == Red then
			Red += 1		
		end
		
		Player.Team = TeamsService[ChosenTeam]
	elseif Blue > Red then
		Player.Team = TeamsService.Blue
		Blue += 1
	end
	for i,v in pairs(game.Players:GetPlayers()) do
		if v.Team ~= "Spectator" then
			print(Red,Blue)
			return true
		end
	end
end

function GameManager.EndGame()
	--get the max points from the team. The team with the most points wins
	local ServerData = game.ServerStorage.ServerData
	local WinningTeam
	local PlayerTable = {}
	
	if ServerData.BluePoints.Value < ServerData.RedPoints.Value then
		print("Blue Won")
		WinningTeam = "Red"
	elseif ServerData.BluePoints.Value > ServerData.RedPoints.Value then
		print("Red Won")
		WinningTeam = "Blue"
	else
		print("Tie")
	end
	for i,v in pairs(game.Players:GetPlayers()) do
		print(WinningTeam, v.Team)
		if v.Team.Name == WinningTeam then
			print("In Winning team")
			game.ServerStorage.PlayerData[v.Name].Wins.Value += 1
		else
			print("Not win")
		end
		
		table.insert(PlayerTable,v)
	end
	warn("Team "..WinningTeam.." won the game!")
	wait(5)

	TeleportService:TeleportAsync(LobbyId,PlayerTable)
end

function GameManager.UpdatePointsDisplay(Player:Player)
	local PointsFrame = Player.PlayerGui.Main.GameInfo
	local ServerInfo = game.ServerStorage.ServerData
	
	PointsFrame.TeamBlue.PointsDisplay.Text = ServerInfo.BluePoints.Value
	PointsFrame.TeamRed.PointsDisplay.Text = ServerInfo.RedPoints.Value

end

return GameManager
