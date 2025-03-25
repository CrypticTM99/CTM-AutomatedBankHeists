-- fxmanifest.lua

fx_version 'cerulean'
game 'gta5'

author 'YourName'
description 'AI Bank Heist Script for QBCore'
version '1.0.0'

server_scripts {
    '@qb-core/shared/locale.lua',  -- QBCore Locale for translations (if any)
    'qb-ai-bank-heist.lua',  -- The main script for AI Bank Heist logic
}

client_scripts {
    '@qb-core/client/target.lua',  -- If you're using QBCore Target System for NPC interaction (optional)
    'client/main.lua',  -- Client-side interaction and logic
}

dependencies {
    'qb-core',  -- Ensure you have the qb-core dependency
}
