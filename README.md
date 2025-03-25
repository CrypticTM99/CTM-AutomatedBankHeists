# AI Bank Heist Mission Script for QBCore

This script adds a fully functional **AI Bank Heist Mission** to your **FiveM RP server**. It spawns AI NPCs when there are **few or no cops online**, offering a dynamic and engaging way to trigger bank heists.

## Features

- **AI Bank Heist**: Triggers a bank heist mission when there are fewer cops online than the required threshold.
- **NPC Spawning**: Spawns NPCs that act as security guards, hostages, and other essential characters for the heist.
- **Customizable Items**: Heist rewards such as cash, gold, and other items can be defined and customized.
- **Integrated Job System**: The heist is tied to the **QBCore** job system, ensuring balance and fairness for players.
- **Cooldown Timer**: Prevents repeated heists too soon by using a cooldown timer.

## Installation

1. **Download the Script**:
   - Download the `qb-ai-bank-heist.lua` script and place it inside the `resources/[your_resource_folder]` directory of your server.

2. **Add the Script to `server.cfg`**:
   - Add `ensure qb-ai-bank-heist` to your `server.cfg` to ensure the script is loaded when the server starts.

3. **Customize NPCs and Heist**:
   - Modify the `Config.HeistNPCs` section to adjust NPCs, weapons, and positions.
   - Modify the `Config.HeistItems` section to change what items the heist rewards.

4. **Customize Heist Conditions**:
   - Set the number of cops required to trigger a heist by modifying the `Config.MinCopsRequired` value.
   - Adjust the heist mission duration and cooldown by changing the `Config.HeistTime` and `Config.HeistCooldownTime` values.

5. **Testing Heist**:
   - To manually trigger the heist for testing or as an admin, use the `/startheist` command in the game console.

## Usage

- The heist mission will automatically trigger when the number of online cops is below the configured minimum (`Config.MinCopsRequired`).
- Heist NPCs will spawn, and the mission timer will start.
- After the timer expires, players can collect the heist rewards.
- Rewards include items defined in the `Config.HeistItems` array (e.g., cash, gold).

## Customization

- **NPC Models**: Customize the NPC models by changing the `model` field in the `Config.HeistNPCs` table. You can use different models for security guards, hostages, and more.
- **Weapons**: Customize the weapons given to the NPCs by adjusting the `weapons` field.
- **Heist Items**: Customize the rewards (items) from the heist by editing the `Config.HeistItems` table.

## License

This script is free to use and modify. No redistribution without crediting the original creator is allowed.

## Credits

- **Script Creator**: [CrypticTM]
- **QBCore Framework**: Developed by **QBCore**.
