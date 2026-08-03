--[[
    LightingEngine[Update] (Script)
    Path: ServerScriptService
    Parent: ServerScriptService
    Properties:
        Disabled: true
    Exported: 2026-08-03 19:31:17 (web)
]]

local PresetModule = require(script.Lighting)


local Presets = {"Day","Evening","Night"}
local RawPreset = math.random(1,#Presets)
local Preset = Presets[RawPreset]

--PresetModule.SetNight()

PresetModule["Set"..Preset]()
warn("[Lighting]: Setting Game mode to "..Preset)
