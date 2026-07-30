--[[
    LocalScript (LocalScript)
    Path: StarterGui → Main → HintFrame
    Parent: HintFrame
    Properties:
        Disabled: false
    Exported: 2026-07-30 17:49:26 (web)
]]

script.Parent.Close.MouseButton1Up:Connect(function()
	script.Parent.Visible = false
	script.Parent.Parent.Hint.Visible = true
end)

script.Parent.Parent.Hint.MouseButton1Up:Connect(function()
	script.Parent.Visible = true
	script.Parent.Parent.Hint.Visible = false
end)