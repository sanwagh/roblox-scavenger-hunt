--[[
    JoinQueue (Script)
    Path: ServerScriptService → AntiCheatEngine → WebhookService
    Parent: WebhookService
    Properties:
        Disabled: false
    Exported: 2026-07-30 17:48:10 (web)
]]

local Url = "https://hooks.hyra.io/api/webhooks/1114172029235626015/PXLPP-WM8KUtazTNEzxBzdewpxRsBJmZJm5JlueZ9Ic0F2Z0DaqHV7zRot4Sjagv985n"
local HttpService = game:GetService("HttpService")
local WebhookService = require(script.Parent)
local Player


game.ReplicatedStorage:WaitForChild("Remotes").AddQueue.OnServerEvent:Connect(function(player, Mode)
	Player = player	
	local Data = {
		['embeds'] = {{
			['title'] = "**"..player.Name.."** has requested to join the QUEUE " ..tostring(Mode),
			['description'] = "",
			['color'] = 000080,
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
	Player.PlayerGui:WaitForChild("Main").QueueFrame.Exit.MouseButton1Up:Connect(function()
		local Data = {
			['embeds'] = {{
				['title'] = "**"..player.Name.."** has Left the QUEUE ",
				['description'] = "",
				['color'] = 010080,
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
	end)

end)

