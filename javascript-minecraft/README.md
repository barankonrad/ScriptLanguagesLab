# Minecraft Castle Generator Script
A script for **Minecraft** that builds a castle using the Minecraft Scripting API. Written in **JavaScript**, it constructs detailed castle features including walls, towers, a moat, a bridge with a gate, and an inner building—all generated automatically in front of the player.

## Features

- **Modular Construction**: Separate functions build walls, towers, tower and wall tops, a moat, a bridge with a gate.
- **Customizable Dimensions**: Easily adjust parameters such as castle width, length, wall thickness, tower dimensions, moat size, and more.

## How to Run

1. **Prepare Your Environment**:  
   Ensure you are using a Minecraft server or world that supports the [Minecraft Scripting API]([https://minecraft.gamepedia.com/Script_API](https://learn.microsoft.com/en-us/minecraft/creator/scriptapi/?view=minecraft-bedrock-stable)) (commonly available in Minecraft Bedrock Edition).

2. **Install the Script**:
    - Place the script file into your server’s or realm’s designated scripting folder.
    - Verify that the dependency `@minecraft/server` is accessible in your environment.

3. **Launch Minecraft**:  
   Start your Minecraft world. The script will automatically run when the world loads.

4. **Watch the Magic Happen**:  
   After joining, check your chat for the "Script loaded!" message. The castle will then be generated in front of the first player in the Overworld.

## Usage Instructions

1. **Enter the World**:  
   Launch your Minecraft world (Overworld) where the script is active.

2. **Script Execution**:  
   On world load, the script sends a confirmation message and immediately spawns the castle structure relative to the first player’s position.

3. **Explore Your Castle**:  
   Walk towards the generated castle to inspect its robust walls, majestic towers, surrounding moat, and inner building complete with a gate and decorative details.

4. **Customize Your Build**:  
   To modify castle dimensions or features, edit the parameter values within the script (see the Customization Example below).

## Customization Example

You can adjust various parameters directly in the script. For instance, in the `spawnCastleInFrontOfPlayer` function, you’ll find code like:

```js
const width = 20;         // Total width of the castle
const length = 30;        // Total length of the castle
const thickness = 2;      // Wall thickness
const wallHeight = 5;     // Height of the castle walls
const towerDiameter = 4;  // Diameter of the corner towers
const towerHeight = 10;   // Height of the towers
const moatLength = 8;     // How far the moat extends from the castle
const moatDepth = 3;      // Depth of the moat
```

## Example
<div align="center">
   <img width="462" alt="Screenshot 2025-01-15 at 22 59 26" src="https://github.com/user-attachments/assets/195bdc94-6af6-4051-a57e-97e2c6861ba5" width="700" alt="Screenshot 1"/>
   <p><i>Screenshot 1: Castle from the outside</i></p>

   <img width="462" alt="Screenshot 2025-01-15 at 22 59 26" src="https://github.com/user-attachments/assets/1d468453-1a42-4656-bbed-3b366124b20b" width="700" alt="Screenshot 1"/>
   <p><i>Screenshot 2: Inner building</i></p>

   <img width="462" alt="Screenshot 2025-01-15 at 22 59 26" src="https://github.com/user-attachments/assets/512f587b-69fa-47fa-8664-27700c2e6b52" width="700" alt="Screenshot 1"/>
   <p><i>Screenshot 3: The gate and moad</i></p>

   <img width="462" alt="Screenshot 2025-01-15 at 22 59 26" src="https://github.com/user-attachments/assets/7368968f-7c4d-412d-b464-2487252af17c" width="700" alt="Screenshot 1"/>
   <p><i>Screenshot 4: Building interior</i></p>


https://github.com/user-attachments/assets/f79db89f-7827-4180-94db-6dc77779eb66

</div>