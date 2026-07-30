--[[
    TutorialUI (ModuleScript)
    Path: ServerScriptService → Tutorial
    Parent: Tutorial
    Properties:
        Disabled: false
    Exported: 2026-07-30 17:49:26 (web)
]]

local TutorialUI = {}

local CurrentStage = 1
local TutorialManagerModule = require(script.Parent.TutorialManager)
local Player

function TutorialUI.ShowUI(player:Player)
	Player = player
	Player.PlayerGui:WaitForChild("Main").TutorialFrame.Visible = true
	
	if TutorialUI.Stage1() then
		TutorialManagerModule.Stage1()
	else
		warn("[TutorialUI]: Func called but nil returned. This should not happen")
	end
end

function TutorialUI.Next()
	Player.PlayerGui.Main.TutorialFrame.Next.Visible = false
	CurrentStage += 1
	
	if TutorialUI["Stage"..CurrentStage]() then
		if TutorialManagerModule["Stage"..CurrentStage](Player) then
			Player.PlayerGui.Main.TutorialFrame.Next.Visible = true
		end
	else
		warn("[TutorialUI]: Func called but nil returned. This should not happen")
	end
end

function TutorialUI.Stage1()
	
	local Txt = "Hello, Welcome to the tutorial of Scavenger Hunt. This will tell how the game is played."
	AnimateText(Txt)
	return true
end

function TutorialUI.Stage2()
	local Txt = "You will be given a hint. With the help of the hint, you have to guess the item."
	AnimateText(Txt)
	return true
end

function TutorialUI.Stage3()
	local Txt = "You have the hint. Guess the item."
	AnimateText(Txt)
	return true
end

function TutorialUI.Stage4()
	local Txt = "Now that you have guessed the item, look for it where it will usually be found."
	AnimateText(Txt)
	return true
end

function TutorialUI.Stage5()
	local Txt = "So a book (the item) will usually be found on a table in a house. Look for it in the houses."
	AnimateText(Txt)
	return true
end

function TutorialUI.Stage6()
	local Txt = "Once you find the item, your team will be rewarded with some points."
	AnimateText(Txt)
	return true
end

function TutorialUI.Stage7()
	local Txt = "This is how the game is supposed to be played. Split your team of efficiency."
	AnimateText(Txt)
	return true
end

function TutorialUI.Stage8()
	local Txt = "You will now be teleported to the lobby."
	AnimateText(Txt)
	return true
end

function AnimateText(Text)
	for i = 1, #Text do
		Player.PlayerGui.Main.TutorialFrame.TutorialFrame.TextLabel.Text =  string.sub(Text, 1, i)
		wait(0.05)
	end
end

return TutorialUI
