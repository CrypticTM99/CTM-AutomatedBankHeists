-- server/main.lua

local QBCore = exports['qb-core']:GetCoreObject()

-- Handle the completion of the heist and reward players
RegisterNetEvent('qb-ai-bank-heist:completeHeist')
AddEventHandler('qb-ai-bank-heist:completeHeist', function()
    -- Reward players involved
    local src = source
    local player = QBCore.Functions.GetPlayer(src)

    if player then
        -- Reward with cash, gold, or other items
        for _, item in ipairs(Config.HeistItems) do
            player.Functions.AddItem(item.name, item.amount)
            TriggerClientEvent('QBCore:Notify', src, "You received " .. item.amount .. " " .. item.name, 'success')
        end
    end
end)
