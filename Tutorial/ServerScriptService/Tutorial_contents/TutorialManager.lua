--[[
    TutorialManager (ModuleScript)
    Path: ServerScriptService → Tutorial
    Parent: Tutorial
    Properties:
        Disabled: false
    Exported: 2026-07-30 17:49:26 (web)
]]

local Tutorial = {}

local TeleportService = game:GetService("TeleportService")

function Tutorial.Stage1(Player:Player)
	print("Tutorial S1")
	return true
end

function Tutorial.Stage2(Player:Player)
	print("Tutorial S2")
	
	return true
end

function Tutorial.Stage3(Player:Player)
	print("Tutorial S3")
	Player.PlayerGui.Main.HintFrame.Visible = true
	return true
end

function Tutorial.Stage4(Player:Player)
	print("Tutorial S4")
	local ItemClone:Model = game.ServerStorage.Book:Clone()
	local RawItemPos = game.Workspace.ItemSpawns:GetChildren()
	
	local ItemPos = math.random(1,#RawItemPos)
	local ItemSpawn = RawItemPos[ItemPos]
	
	RawItemPos = nil
	ItemPos = nil
	
	ItemClone:PivotTo(ItemSpawn.CFrame)
	ItemClone.Parent = workspace
	
	return true
end


function Tutorial.Stage5(Player:Player)
	local ItemGot = false

	while ItemGot == false do
		wait()
		print("loop")
		game.Workspace:WaitForChild("Book").ProximityPart.ProximityPrompt.TriggerEnded:Connect(function()
			ItemGot = true
			print("Trigg")
		end)
		if ItemGot == true then
			game.Workspace.Book:Destroy()
			break
		end
	end
	return true
end


function Tutorial.Stage6(Player:Player)
	
	return true
end

function Tutorial.Stage7(Player:Player)

	return true
end

function Tutorial.Stage8(Player:Player)
	local PlayerTable = {Player}
	wait(1)
	TeleportService:TeleportAsync(13400779039, PlayerTable)
	return true
end


return Tutorial
