--[[
    WebhookService (ModuleScript)
    Path: ServerScriptService → AntiCheatEngine
    Parent: AntiCheatEngine
    Properties:
        Disabled: false
    Exported: 2026-08-03 19:31:17 (web)
]]

local WebhookService = {}

local HttpService = game:GetService("HttpService")

function WebhookService:CreateMessage(url, Message)
	local Data = {
		["content"] = Message
	}
	local FinalData = HttpService:JSONEncode(Data)
	HttpService:PostAsync(url, FinalData)
end


function WebhookService:CreateEmbed(url,title,message,image)
	local Data = {
		['content'] = "",
		['embeds'] = {{
			['author'] = {
				['name'] = title,
				['icon_url'] = image,

			},
			['description'] = message,
			['type'] = "rich",
			['color'] = tonumber(0xffffff)			
		}}
	}
	local FinalData = HttpService:JSONEncode(Data)
	HttpService:PostAsync(url, FinalData)
end

return WebhookService
