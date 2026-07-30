--[[
    GameModeUI (ModuleScript)
    Path: ReplicatedStorage → Modules → GameModes
    Parent: GameModes
    Properties:
        Disabled: false
    Exported: 2026-07-30 17:48:10 (web)
]]

local GameModes = {}

local Player = game.Players.LocalPlayer
local PlayerGui = Player.PlayerGui
local Main = PlayerGui.Main

local Duels = 4
local Squads = 8

function GameModes.Open()
	Main.GameModes:TweenPosition(
		UDim2.new(0.5,0,0.5,0),
		Enum.EasingDirection.In,
		Enum.EasingStyle.Sine,
		0.9,
		true
	)	
end

function GameModes.Close()
	Main.GameModes:TweenPosition(
		UDim2.new(0.5,0,-1.5,0),
		Enum.EasingDirection.In,
		Enum.EasingStyle.Sine,
		0.9,
		true
	)	
	
end

function GameModes.SeletedMode(Mode) -- mode - string
	print("Selected Game Mode: "..Mode)
	GameModes.InitiateMatchmaking(Mode)
end

function GameModes.InitiateMatchmaking(Mode)
	game.ReplicatedStorage.Remotes.AddQueue:FireServer(Mode)
end

return GameModes
