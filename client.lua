-- client/main.lua

local QBCore = exports['qb-core']:GetCoreObject()

-- Handle the start of the heist timer when the mission is triggered
RegisterNetEvent('qb-ai-bank-heist:startTimer')
AddEventHandler('qb-ai-bank-heist:startTimer', function(timer)
    -- Create a timer and notify the player
    SetTimeout(timer * 1000, function()
        TriggerEvent('qb-ai-bank-heist:completeHeist')
    end)

    -- Inform the player about the heist countdown
    QBCore.Functions.Notify("The heist is in progress! You have " .. (timer / 60) .. " minutes to complete it.", "error")
end)

-- Function to notify players of mission completion
RegisterNetEvent('qb-ai-bank-heist:completeHeist')
AddEventHandler('qb-ai-bank-heist:completeHeist', function()
    QBCore.Functions.Notify("The bank heist has been completed successfully!", "success")
    -- You can also add a UI notification or a sound to make it more interactive.
end)
