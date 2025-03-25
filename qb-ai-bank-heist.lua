-- qb-ai-bank-heist.lua
-- AI Bank Heist Script for FiveM using QBCore
-- This script adds a fully functional AI bank heist for your RP server with NPCs, job triggers, and a mission system

local QBCore = exports['qb-core']:GetCoreObject()

-- Config settings for the AI Heist
Config = {
    -- Minimum number of cops online required to trigger the heist
    MinCopsRequired = 2, 

    -- Heist location and time settings
    HeistLocation = vector3(150.0, -1040.0, 29.0),  -- Example bank location (customize for your server)
    HeistTime = 600,  -- Time for players to finish the heist in seconds (10 minutes)
    HeistCooldown = 3600,  -- Cooldown for triggering the heist in seconds (1 hour)
    HeistItems = {
        {name = 'cash', amount = 50000},  -- Cash reward
        {name = 'gold', amount = 5}  -- Example: gold bars
    },
    
    -- NPC Spawn and Heist Setup
    HeistNPCs = {
        {
            model = "s_m_m_security_01",  -- Security Guard NPC model
            position = vector3(150.0, -1040.0, 29.0),
            heading = 90.0,
            weapons = {"WEAPON_PISTOL", "WEAPON_NIGHTSTICK"},
            behavior = "hostile"
        },
        {
            model = "a_m_m_business_01",  -- Hostage NPC model
            position = vector3(151.0, -1035.0, 29.0),
            heading = 90.0,
            weapons = {"WEAPON_UNARMED"},
            behavior = "passive"
        }
    },
    
    -- Heist Mission Parameters
    HeistCooldownTime = 60 * 60,  -- 1 hour cooldown between heists
    PoliceNotified = false,
}

-- Function to get the number of cops online
function GetCopsOnline()
    local copsOnline = 0
    for _, playerId in pairs(QBCore.Functions.GetPlayers()) do
        local player = QBCore.Functions.GetPlayer(playerId)
        if player and player.Job.name == 'police' then
            copsOnline = copsOnline + 1
        end
    end
    return copsOnline
end

-- Function to start the heist mission
function StartHeistMission()
    local copsOnline = GetCopsOnline()
    if copsOnline < Config.MinCopsRequired then
        -- Notify players that the heist is in progress
        TriggerClientEvent('QBCore:Notify', -1, "A bank heist is happening! Few cops are online!", 'error')

        -- Spawn Heist NPCs
        for _, npc in ipairs(Config.HeistNPCs) do
            local model = npc.model
            RequestModel(model)
            while not HasModelLoaded(model) do
                Wait(500)
            end

            -- Create NPCs based on their behavior (hostile or passive)
            local npcPed = CreatePed(4, model, npc.position.x, npc.position.y, npc.position.z, npc.heading, false, true)
            SetEntityInvincible(npcPed, true)
            SetPedArmour(npcPed, 100)
            GiveWeaponToPed(npcPed, GetHashKey(npc.weapons[1]), 1, false, true)

            -- Different behaviors for NPCs
            if npc.behavior == "hostile" then
                TaskCombatPed(npcPed, PlayerPedId(), 0, 16)
            elseif npc.behavior == "passive" then
                TaskReactAndFleePed(npcPed, PlayerPedId())
            end
        end

        -- Start Heist Timer for Players
        TriggerClientEvent('qb-ai-bank-heist:startTimer', -1, Config.HeistTime)

        -- Reward players when the timer expires
        SetTimeout(Config.HeistTime * 1000, function()
            CompleteHeist()
        end)
    else
        TriggerClientEvent('QBCore:Notify', -1, "Not enough cops online to start the heist.", 'error')
    end
end

-- Function to complete the heist and reward players
function CompleteHeist()
    -- Notify players that the heist is completed
    TriggerClientEvent('QBCore:Notify', -1, "The bank heist has been completed successfully!", 'success')

    -- Reward players involved in the heist (e.g., cash, gold)
    local players = GetPlayers()
    for _, playerId in pairs(players) do
        local player = QBCore.Functions.GetPlayer(playerId)
        if player then
            -- Add items to player's inventory
            for _, item in ipairs(Config.HeistItems) do
                player.Functions.AddItem(item.name, item.amount)
                TriggerClientEvent('QBCore:Notify', playerId, "You received " .. item.amount .. " " .. item.name, 'success')
            end
        end
    end

    -- Reset cooldown for the next heist
    Config.PoliceNotified = false
    TriggerClientEvent('QBCore:Notify', -1, "The heist is over. Wait before the next one!", 'success')
end

-- Function to trigger heist when police count is low
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000 * 60)  -- Check every minute
        local copsOnline = GetCopsOnline()
        if copsOnline < Config.MinCopsRequired and not Config.PoliceNotified then
            StartHeistMission()
            Config.PoliceNotified = true
        end
    end
end)

-- Command to manually trigger heist for testing or admin use
RegisterCommand('startheist', function()
    local copsOnline = GetCopsOnline()
    if copsOnline < Config.MinCopsRequired then
        StartHeistMission()
    else
        print("Not enough cops online to start a heist.")
    end
end, false)

-- Add an event to notify players when the heist timer starts (client-side)
RegisterNetEvent('qb-ai-bank-heist:startTimer')
AddEventHandler('qb-ai-bank-heist:startTimer', function(timer)
    SetTimeout(timer * 1000, function()
        -- Handle after the heist is completed
        TriggerEvent('qb-ai-bank-heist:completeHeist')
    end)
end)
