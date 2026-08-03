--[[
    RoundSystem (ModuleScript)
    Path: ServerScriptService → Main
    Parent: Main
    Properties:
        Disabled: false
    Exported: 2026-08-03 19:31:17 (web)
]]

local RoundSystem = {}

local ItemCollectionModule = require(script.Parent.ItemCollection)
local GameManagerModule = require(script.Parent.GameManager)
local Rounds = 1

local ItemsSpawned = {}

function RoundSystem.Round(Player)
	while true do
		
		warn("Started Round. Round: "..Rounds)
		
		Player.PlayerGui.Main.RoundInfo:TweenPosition(
			UDim2.new(0.5,0,0.5,0),
			Enum.EasingDirection.In,
			Enum.EasingStyle.Sine,
			0.5,
			true
		)
		
		Player.PlayerGui.Main.RoundInfo.TextLabel.Text = "Round "..Rounds
		
		game.Workspace.Decorations.SpawnBox.SpawnBoxModel.Base.CanCollide = false
		wait(2)
		Player.PlayerGui.Main.RoundInfo:TweenPosition(
			UDim2.new(1.5,0,0.5,0),
			Enum.EasingDirection.In,
			Enum.EasingStyle.Sine,
			0.5,
			true
		)
		Player.PlayerGui.Main.GameInfo.RoundNo.RoundNum.Text = Rounds
		
		Player.PlayerGui.Main.GameInfo:TweenPosition(
			UDim2.new(0.5,0,0.12,0),
			Enum.EasingDirection.In,
			Enum.EasingStyle.Sine,
			1.5,
			true
		)
		Player.PlayerGui.Main.RoundInfo.Position = UDim2.new(-1.5,0,0.5,0)


		local RawObjType = math.random(1,100)
		local ObjType

		if RawObjType%5 == 0 then
			ObjType = "Hint"
		else
			ObjType = "Item"
		end
		
		print(ItemsSpawned)

		RawObjType = nil

		
		local Item = ChooseItem() -- ObjType: Instance
		
		
		

		Player.PlayerGui.Main.HintFrame.HintHolder.Hint.Text = game.ServerStorage.Spawnables.Items[Item.Name].Hint.Value
		Player.PlayerGui.Main.HintFrame.Visible = true

		

		if ObjType == "Hint" then
			print("Hint")
			local ItemPosList = game.Workspace.ItemSpawns[Item.Name]:GetChildren()
			local RawPos = math.random(1,#ItemPosList)
			local ItemPos = ItemPosList[RawPos]
			

			local HintClone = game.ServerStorage.Spawnables.Hints.hint:Clone()
			HintClone.Parent = workspace.SpawnedItems
			HintClone.PrimaryPart.Position = ItemPos.Position
			ItemCollectionModule.Detect()


			RawPos = nil 
			while game.ServerStorage.ObjCollected.Value == false do
				wait()

			end
			game.ServerStorage.ObjCollected.Value = false

			continue


		elseif ObjType == "Item" then
			print("Object")
			local ItemPosList = game.Workspace.ItemSpawns[Item.Name]:GetChildren()
			local RawPos = math.random(1,#ItemPosList)
			local ItemPos = ItemPosList[RawPos]

			RawPos = nil 

			local ItemClone:Model = game.ServerStorage.Spawnables.Items[Item.Name]:Clone()
			ItemClone.Parent = game.Workspace.SpawnedItems
			ItemClone:PivotTo(ItemPos.CFrame)
			ItemCollectionModule.Detect()

			while game.ServerStorage.ObjCollected.Value == false do
				wait()

			end
		end
		game.ServerStorage.ObjCollected.Value = false
		
		Rounds += 1


		if Rounds >= 6 then
			print("GameOver")
			GameManagerModule.EndGame()
			break
		end
	end
end

function ChooseItem()
	local ItemList = game.ServerStorage.Spawnables.Items:GetChildren()
	local RawItem = math.random(1,#ItemList)
	local Item = ItemList[RawItem]
	if ItemsSpawned[Item.Name] == nil then
		table.insert(ItemsSpawned,Item.Name)
	else
		ChooseItem()
	end
	
	return Item
end



return RoundSystem
