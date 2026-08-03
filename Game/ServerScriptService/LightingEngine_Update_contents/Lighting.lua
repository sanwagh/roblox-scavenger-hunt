--[[
    Lighting (ModuleScript)
    Path: ServerScriptService → LightingEngine[Update]
    Parent: LightingEngine[Update]
    Properties:
        Disabled: false
    Exported: 2026-08-03 19:31:17 (web)
]]

local Preset = {}

local Lighting = game:WaitForChild("Lighting")
local Atmosphere = Lighting:WaitForChild("Atmosphere")
local ColorCorrection = Lighting:WaitForChild("ColorCorrection")
local SunRays = Lighting:WaitForChild("SunRays")
local Bloom = Lighting:WaitForChild("Bloom")


--LOOPS TO TURN ON/OFF THE LIGHTS

function Preset.SetDay()
	
	Lighting.Ambient = Color3.fromRGB(130, 130, 130)
	Lighting.Brightness = 3
	Lighting.ColorShift_Bottom = Color3.new(0,0,0)
	Lighting.ColorShift_Top = Color3.fromRGB(216,180,116)
	Lighting.OutdoorAmbient = Color3.fromRGB(118,146,189)
	Lighting.ShadowSoftness = 0.15
	Lighting.ClockTime = 14.115
	Lighting.GeographicLatitude = 3.961
	Lighting.ExposureCompensation = 0.1
	
	--Atmosphere
	Atmosphere.Density = 0.357
	Atmosphere.Offset = 1
	Atmosphere.Color = Color3.fromRGB(95,175,212)
	Atmosphere.Decay = Color3.fromRGB(255,255,255)
	Atmosphere.Glare = 0
	Atmosphere.Haze = 0.01	
	
	--ColorCorrection
	ColorCorrection.Brightness = -0.15
	ColorCorrection.Contrast = 0.2
	ColorCorrection.Saturation = -0.1
	ColorCorrection.TintColor = Color3.fromRGB(255,255,255)
	
	--SunRays
	SunRays.Intensity = 0.119
	SunRays.Spread = 0.833
	
	--Bloom
	Bloom.Enabled = false
	
	for i,v in pairs(game.Workspace.Decorations.Lights:GetDescendants()) do
		if v:IsA("PointLight") then
			v.Enabled = false
		end
	end
	
end

function Preset.SetNight()
	
	Lighting.Ambient = Color3.fromRGB(135,135,135)
	Lighting.Brightness = 3.5
	Lighting.ColorShift_Bottom = Color3.new(0,0,0)
	Lighting.ColorShift_Top = Color3.fromRGB(216,180,116)
	Lighting.OutdoorAmbient = Color3.fromRGB(118,146,189)
	Lighting.ShadowSoftness = 0.15
	Lighting.ClockTime = 2.8
	Lighting.GeographicLatitude = 10
	Lighting.ExposureCompensation = 0.2

	--Atmosphere
	Atmosphere.Density = 0.4
	Atmosphere.Offset = 1
	Atmosphere.Color = Color3.fromRGB(95,175,212)
	Atmosphere.Decay = Color3.fromRGB(255,255,255)
	Atmosphere.Glare = 0
	Atmosphere.Haze = 0.01	

	--ColorCorrection
	ColorCorrection.Brightness = -0.1
	ColorCorrection.Contrast = 0.1
	ColorCorrection.Saturation = 0.1
	ColorCorrection.TintColor = Color3.fromRGB(255,255,255)
	
	--Bloom
	Bloom.Enabled = true
	
	for i,v in pairs(game.Workspace.Decorations.Lights:GetDescendants()) do
		if v:IsA("PointLight") then
			v.Enabled = true
		end
	end
	
end

function Preset.SetEvening()
	Lighting.Ambient = Color3.fromRGB(77,77,77)
	Lighting.Brightness = 2
	Lighting.ColorShift_Bottom = Color3.new(0,0,0)
	Lighting.ColorShift_Top = Color3.fromRGB(216,180,116)
	Lighting.OutdoorAmbient = Color3.fromRGB(118,146,189)
	Lighting.ShadowSoftness = 0.15
	Lighting.ClockTime = 17.9
	Lighting.GeographicLatitude = 25
	Lighting.ExposureCompensation = 0.2

	--Atmosphere
	Atmosphere.Density = 0.333
	Atmosphere.Offset = 1
	Atmosphere.Color = Color3.fromRGB(95,175,212)
	Atmosphere.Decay = Color3.fromRGB(255,255,255)
	Atmosphere.Glare = 0
	Atmosphere.Haze = 0.01	

	--ColorCorrection
	ColorCorrection.Brightness = -0.05
	ColorCorrection.Contrast = 0.3
	ColorCorrection.Saturation = 0.1
	ColorCorrection.TintColor = Color3.fromRGB(255,255,255)

	--SunRays
	SunRays.Intensity = 0.071
	SunRays.Spread = 0.286
	
	--Bloom
	Bloom.Enabled = true
	
	--Lights
	for i,v in pairs(game.Workspace.Decorations.Lights:GetDescendants()) do
		if v:IsA("PointLight") then
			v.Enabled = true
		end
	end
end

return Preset
