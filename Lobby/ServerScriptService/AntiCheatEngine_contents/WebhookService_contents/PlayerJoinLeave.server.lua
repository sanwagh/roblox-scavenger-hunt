--[[
    PlayerJoinLeave (Script)
    Path: ServerScriptService → AntiCheatEngine → WebhookService
    Parent: WebhookService
    Properties:
        Disabled: false
    Exported: 2026-07-30 17:48:10 (web)
]]

local Url = "https://hooks.hyra.io/api/webhooks/1114172029235626015/PXLPP-WM8KUtazTNEzxBzdewpxRsBJmZJm5JlueZ9Ic0F2Z0DaqHV7zRot4Sjagv985n"
local HttpService = game:GetService("HttpService")
local WebhookService = require(script.Parent)

game.Players.PlayerAdded:Connect(function(player)
	wait(2)
	local Data = {
		['embeds'] = {{
			['title'] = player.Name.." has JOINED the MAIN LOBBY",
			['description'] = "",
			['color'] = 808000,
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
				{
					['name'] = "Joins",
					['value'] = game.ServerStorage.PlayerInfo[player.Name].Joins.Value,
					['inline'] = true
				},
				{
					['name'] = "Player Banned:",
					['value'] = game.ServerStorage.AntiCheatData:WaitForChild(player.Name).PlayerBanned.Value,
					['inline'] = false
				},
				{
					['name'] = "Ban Reason:",
					['value'] = game.ServerStorage.AntiCheatData:WaitForChild(player.Name).BanReason.Value,
					['inline'] = false
				}
			}
		}}
	}
	local FinalData = HttpService:JSONEncode(Data)
	HttpService:PostAsync(Url,FinalData)
end)

