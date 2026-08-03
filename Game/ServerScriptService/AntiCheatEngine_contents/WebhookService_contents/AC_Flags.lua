--[[
    AC_Flags (ModuleScript)
    Path: ServerScriptService → AntiCheatEngine → WebhookService
    Parent: WebhookService
    Properties:
        Disabled: false
    Exported: 2026-08-03 19:31:17 (web)
]]

local AC_Flags = {}

local Url = "https://hooks.hyra.io/api/webhooks/1114172029235626015/PXLPP-WM8KUtazTNEzxBzdewpxRsBJmZJm5JlueZ9Ic0F2Z0DaqHV7zRot4Sjagv985n"
local HttpService = game:GetService("HttpService")
local WebhookService = require(script.Parent)

function AC_Flags.SendFlagData(player, Reason)
	
	local Data = {
		['embeds'] = {{
			['title'] = player.Name.." has been flagged for "..tostring(Reason),
			['description'] = "",
			['color'] = 868000,
			['url'] = "https://www.roblox.com/users/"..player.UserId.."/profile",

			['fields'] = {
				{
					['name'] = "Account age: ",
					['value'] = player.AccountAge.." Days",
					['inline'] = true
				},
				{
					['name'] = "UserId: ",
					['value'] = player.UserId,
					['inline'] = true
				},
				{
					['name'] = "AC_FLAGS",
					['value'] = game.ServerStorage.AntiCheatData:WaitForChild(player.Name).Flags.Value,
					['inline'] = true
				},
			}
		}}
	}
	local FinalData = HttpService:JSONEncode(Data)
	HttpService:PostAsync(Url,FinalData)
	return
end

return AC_Flags
