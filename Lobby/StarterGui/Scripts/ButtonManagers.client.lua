--[[
    ButtonManagers (LocalScript)
    Path: StarterGui → Scripts
    Parent: Scripts
    Properties:
        Disabled: false
    Exported: 2026-07-30 17:48:10 (web)
]]

local Player = game.Players.LocalPlayer

--Services
local PlayerGui = Player.PlayerGui

-- UserInterface
local Main = PlayerGui.Main
local GameModes = Main.GameModes

--Modules
local GameModeModule = require(game.ReplicatedStorage:WaitForChild("Modules").GameModes.GameModesManager)


-----Game Modes Manager

Main.Play.MouseButton1Up:Connect(function()
	game.SoundService.Sounds.Click:Play()
	Main.Play.Visible = false
	GameModeModule.Open()
end)

GameModes.Close.MouseButton1Up:Connect(function()
	game.SoundService.Sounds.Click:Play()
	Main.Play.Visible = true
	GameModeModule.Close()
end)

coroutine.resume(coroutine.create(function()
	for i,v in pairs(GameModes.GameModeFolder:GetChildren()) do
		if v:IsA("TextButton") then
			v.MouseButton1Up:Connect(function()
				print("Clicked")
				game.SoundService.Sounds.Click:Play()
				-- Some effects
				GameModeModule.SeletedMode(v.Name)
				GameModeModule.Close()
				--Timer ui
			end)
		end
	end
end))

Main.QueueFrame.Exit.MouseButton1Up:Connect(function()
	game.SoundService.Sounds.Click:Play()
	Main.Play.Visible = true
end)