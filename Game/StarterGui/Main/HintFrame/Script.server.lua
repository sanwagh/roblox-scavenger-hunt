--[[
    Script (Script)
    Path: StarterGui → Main → HintFrame
    Parent: HintFrame
    Properties:
        Disabled: false
    Exported: 2026-08-03 19:31:17 (web)
]]

local Player = script.Parent.Parent.Parent.Parent

script.Parent.Close.MouseButton1Up:Connect(function()
	script.Parent.Visible = false
	script.Parent.Parent.HintBtn.Visible = true
end)


script.Parent.Parent.HintBtn.MouseButton1Up:Connect(function()
	script.Parent.Visible = true
	script.Parent.Parent.HintBtn.Visible = false
end)