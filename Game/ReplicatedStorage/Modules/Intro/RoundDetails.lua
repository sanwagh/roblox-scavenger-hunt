--[[
    RoundDetails (ModuleScript)
    Path: ReplicatedStorage → Modules → Intro
    Parent: Intro
    Properties:
        Disabled: false
    Exported: 2026-08-03 19:31:17 (web)
]]

local Details = {}

local player = game.Players.LocalPlayer
local PlayerGui = player.PlayerGui
local Info = PlayerGui:WaitForChild("Main").InfoFrame.Info

function Details.GameDetails()
	Info.Parent.Visible = true
	for i = 15,0,-1 do
		Info.Text = "Starting Game: "..i
		wait(1)
	end
	wait(1)
	
	local Text = {
		"Hello, Welcome to a round of Scavenger hunt.",
		[["Find the item with the hint given to you before the other team does. 
		The team with the most points wins"]],
		"Good luck and have fun"
	}
	Info.Parent.Visible = true
	
	for i = 1, #Text[1] do
		Info.Text = string.sub(Text[1],1,i)
		wait(0.04) 
	end
	wait(1)
	for i = 1, #Text[2] do
		Info.Text = string.sub(Text[2],1,i)
		wait(0.04)
	end
	wait(2)
	for i = 1, #Text[3] do
		Info.Text = string.sub(Text[3],1,i)
		wait(0.04)
	end
	wait(2)
	Info.Parent.Visible = false
	Details.RoundDetails()	
end


function Details.RoundDetails()
	game.ReplicatedStorage.Remotes.Round:FireServer(1)
end

return Details
