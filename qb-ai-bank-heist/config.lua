-- qb-ai-bank-heist/config.lua

Config = {
    -- Minimum number of cops required to trigger the heist
    MinCopsRequired = 2, 

    -- Heist time limit (in seconds)
    HeistTime = 600,  -- 10 minutes

    -- NPCs settings
    HeistNPCs = {
        {
            model = "s_m_m_security_01",
            position = vector3(150.0, -1040.0, 29.0),
            heading = 90.0,
            weapons = {"WEAPON_PISTOL", "WEAPON_NIGHTSTICK"},
            behavior = "hostile"
        },
        {
            model = "a_m_m_business_01",
            position = vector3(151.0, -1035.0, 29.0),
            heading = 90.0,
            weapons = {"WEAPON_UNARMED"},
            behavior = "passive"
        }
    },
    -- Items given as rewards
    HeistItems = {
        {name = 'cash', amount = 50000},
        {name = 'gold', amount = 5}
    },
    HeistCooldown = 3600,  -- 1 hour cooldown
    PoliceNotified = false,
}
