--[[
    RagdollDeath (Script)
    Path: ServerScriptService → Misc
    Parent: Misc
    Properties:
        Disabled: false
    Exported: 2026-07-30 17:48:10 (web)
]]

game.Players.PlayerAdded:Connect(function(play)
	play.CharacterAdded:Connect(function(char)
  		char.Humanoid.BreakJointsOnDeath = false
			char.Humanoid.Died:Connect(function()
				if char:FindFirstChild("HumanoidRootPart") then
					for _, v in pairs(char:GetDescendants()) do
						if v:IsA("Motor6D") then
							local a0, a1 = Instance.new("Attachment"), Instance.new("Attachment")
							a0.CFrame = v.C0
							a1.CFrame = v.C1
							a0.Parent = v.Part0
							a1.Parent = v.Part1
							
							v.Part0.CanCollide = true
							v.Part1.CanCollide = true
							
							local b = Instance.new("BallSocketConstraint")
							b.Attachment0 = a0
							b.Attachment1 = a1
							b.Parent = v.Part0
							
							v:Destroy()
						end
	    			end
	   			end
   			char.HumanoidRootPart.CanCollide = false
  		end)
 	end)
end)