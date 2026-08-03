--[[
    ItemCollection (ModuleScript)
    Path: ServerScriptService → Main
    Parent: Main
    Properties:
        Disabled: false
    Exported: 2026-08-03 19:31:17 (web)
]]

local ItemCollecttion = {}

function ItemCollecttion.Detect()
	for i,v in pairs(game.Workspace.SpawnedItems:GetChildren()) do
		v.ProximityPrompt.Triggered:Connect(function(player)
			print(player)
			game.ServerStorage.ObjCollected.Value = true
			local PlayerTeam = player.Team
			print(tostring(PlayerTeam).." Found The item!")
			game.ServerStorage.ServerData[tostring(PlayerTeam).."Points"].Value += 10
			v:Destroy()
		end)
	end
end

return ItemCollecttion
