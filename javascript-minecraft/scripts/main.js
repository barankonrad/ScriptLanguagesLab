import {world} from "@minecraft/server";

const dimension = world.getDimension("overworld");

function setBlockAtPosition(position, blockType) {
  const block = dimension.getBlock(position);
  if (block) {
    block.setType(blockType);
  }
}

function fillArea(xStart, xEnd, zStart, zEnd, yLoc, height, block) {
  for (let y = 0; y < height; y++) {
    for (let x = xStart; x <= xEnd; x++) {
      for (let z = zStart; z <= zEnd; z++) {
        setBlockAtPosition({x: x, y: yLoc + y, z: z}, block);
      }
    }
  }
}

function createTowerTop(location, height, xStart, xEnd, zStart, zEnd, block) {
  const y = location.y + height;
  const xStartTop = xStart - 1;
  const xEndTop = xEnd + 1;
  const zStartTop = zStart - 1;
  const zEndTop = zEnd + 1;
  let flag = true

  for (let x = xStartTop; x <= xEndTop; x++) {
    let counter = 0;
    for (let z = zStartTop; z <= zEndTop; z++) {
      counter++;
      if (x === xStartTop || x === xEndTop || z === zStartTop || z
          === zEndTop) {
        setBlockAtPosition({x: x, y: y, z: z}, block);
      }
      if ((x === xStartTop || x === xEndTop || z === zStartTop || z === zEndTop)
          && counter % 2 === (+flag)) {
        setBlockAtPosition({x: x, y: y + 1, z: z}, block);
      }
    }
    flag = !flag;
  }
}

function buildTower(location, diameter, height) {
  const move = diameter / 2;
  const xStart = location.x - move;
  const zStart = location.z - move;
  const xEnd = location.x + move;
  const zEnd = location.z + move;
  fillArea(xStart, xEnd, zStart, zEnd, location.y, height,
      "minecraft:cobblestone");
  createTowerTop(location, height, xStart, xEnd, zStart, zEnd,
      "minecraft:cobblestone");
}

function createWallTop(location, xStart, xEnd, zStart, zEnd, thickness, height,
    block) {
  const y = location.y + height;
  const xStartTop = xStart - 1;
  const xEndTop = xEnd + 1;
  const zStartTop = zStart - 1;
  const zEndTop = zEnd + 1;
  let flag = true;
  for (let x = xStartTop; x <= xEndTop; x++) {
    let counter = 0;
    for (let z = zStartTop; z <= zEndTop; z++) {
      counter++;
      if (x === xStartTop || x === xEndTop || z === zStartTop || z
          === zEndTop) {
        setBlockAtPosition({x: x, y: y, z: z}, block);
      }
      if ((x === xStartTop || x === xEndTop || z === zStartTop || z === zEndTop)
          && counter % 2 === (+flag)) {
        setBlockAtPosition({x: x, y: y + 1, z: z}, block);
      }
    }
    flag = !flag;
  }
}

function buildWallAround(location, width, length, thickness, height) {
  const xHalf = width / 2;
  const zHalf = length / 2;
  const xStart = Math.floor(location.x - xHalf);
  const xEnd = Math.floor(location.x + xHalf - 1);
  const zStart = Math.floor(location.z - zHalf);
  const zEnd = Math.floor(location.z + zHalf - 1);

  fillArea(xStart, xEnd,
      zStart, zStart + thickness - 1,
      location.y, height,
      "minecraft:cobblestone");
  fillArea(xStart, xEnd,
      zEnd - thickness + 1, zEnd,
      location.y, height,
      "minecraft:cobblestone");

  fillArea(xStart, xStart + thickness - 1,
      zStart + thickness, zEnd - thickness,
      location.y, height,
      "minecraft:cobblestone");
  fillArea(xEnd - thickness + 1, xEnd,
      zStart + thickness, zEnd - thickness,
      location.y, height,
      "minecraft:cobblestone");
  createWallTop(location,
      xStart, xEnd,
      zStart, zEnd,
      thickness, height,
      "minecraft:cobblestone");
}

function buildCastle(location, width, length, thickness, wallHeight,
    towerDiameter, towerHeight) {
  buildWallAround(location, width, length, thickness, wallHeight);
  const xHalf = width / 2;
  const zHalf = length / 2;
  const xStart = Math.floor(location.x - xHalf);
  const xEnd = Math.floor(location.x + xHalf - 1);
  const zStart = Math.floor(location.z - zHalf);
  const zEnd = Math.floor(location.z + zHalf - 1);
  buildTower({x: xStart, y: location.y, z: zStart}, towerDiameter, towerHeight);
  buildTower({x: xEnd, y: location.y, z: zStart}, towerDiameter, towerHeight);
  buildTower({x: xStart, y: location.y, z: zEnd}, towerDiameter, towerHeight);
  buildTower({x: xEnd, y: location.y, z: zEnd}, towerDiameter, towerHeight);
}

function buildBridgeAndGate(location, width, length, thickness, moatLength) {
  const xHalf = width / 2;
  const zHalf = length / 2;
  const xStart = Math.floor(location.x - xHalf);
  const xEnd = Math.floor(location.x + xHalf - 1);
  const zStart = Math.floor(location.z - zHalf);
  const gateHeight = 4;
  const midX = Math.floor((xStart + xEnd) / 2);
  fillArea(midX - 1, midX + 1,
      zStart, zStart + thickness - 1,
      location.y, gateHeight,
      "minecraft:air");
  const zBridgeStart = zStart - moatLength - 3;
  const zBridgeEnd = zStart - 1;
  fillArea(midX - 1, midX + 1,
      zBridgeStart, zBridgeEnd,
      location.y, 1,
      "minecraft:oak_planks");
  fillArea(midX - 2, midX - 2,
      zBridgeStart, zBridgeEnd,
      location.y, 1,
      "minecraft:oak_fence");
  fillArea(midX + 2, midX + 2,
      zBridgeStart, zBridgeEnd,
      location.y, 1,
      "minecraft:oak_fence");
}

function buildMoat(location, width, length, thickness, moatLength, moatDepth) {
  const xHalf = width / 2;
  const zHalf = length / 2;
  const xStart = Math.floor(location.x - xHalf - 2);
  const xEnd = Math.floor(location.x + xHalf + 1);
  const zStart = Math.floor(location.z - zHalf - 2);
  const zEnd = Math.floor(location.z + zHalf + 1);
  const outerMinX = xStart - moatLength;
  const outerMaxX = xEnd + moatLength;
  const outerMinZ = zStart - moatLength;
  const outerMaxZ = zEnd + moatLength;
  fillArea(outerMinX, outerMaxX,
      outerMinZ, outerMaxZ,
      location.y - moatDepth, moatDepth,
      "minecraft:water");
  fillArea(xStart, xEnd,
      zStart, zEnd,
      location.y - moatDepth, moatDepth,
      "minecraft:grass_block");
}

function buildInnerBuilding(castleLocation) {
  const buildingWidth = 11;
  const buildingLength = 14;
  const buildingHeight = 7;
  const centerX = castleLocation.x;
  const centerZ = castleLocation.z;
  const baseY = castleLocation.y;
  const xStart = Math.floor(centerX - buildingWidth / 2);
  const xEnd = xStart + buildingWidth - 1;
  const zStart = Math.floor(centerZ - buildingLength / 2);
  const zEnd = zStart + buildingLength - 1;
  fillArea(xStart, xEnd,
      zStart, zEnd,
      baseY, 1,
      "minecraft:stone_bricks");
  for (let y = 1; y <= buildingHeight; y++) {
    for (let x = xStart; x <= xEnd; x++) {
      for (let z = zStart; z <= zEnd; z++) {
        if (x === xStart || x === xEnd || z === zStart || z === zEnd) {
          const isCorner = (x === xStart || x === xEnd) && (z === zStart || z
              === zEnd);
          if (isCorner) {
            setBlockAtPosition({x, y: baseY + y, z}, "minecraft:oak_log");
          } else {
            setBlockAtPosition({x, y: baseY + y, z}, "minecraft:stone_bricks");
          }
        }
      }
    }
  }
  const doorCenterX = Math.floor((xStart + xEnd) / 2);
  for (let doorY = baseY + 1; doorY <= baseY + 3; doorY++) {
    for (let dx = doorCenterX - 1; dx <= doorCenterX + 1; dx++) {
      setBlockAtPosition({x: dx, y: doorY, z: zStart}, "minecraft:air");
    }
  }
  const windowTop = baseY + 4;
  const windowStart = baseY + 2;

  function placeVerticalIronBars(x, z) {
    for (let wy = windowStart; wy <= windowTop; wy++) {
      setBlockAtPosition({x, y: wy, z}, "minecraft:iron_bars");
    }
  }
  {
    const backWallWidth = (xEnd - 1) - (xStart + 1) + 1;
    const segment = Math.floor(backWallWidth / 3);
    let currentX = xStart + 1;
    for (let i = 0; i < 3; i++) {
      const wx = currentX + Math.floor(segment / 2);
      placeVerticalIronBars(wx, zEnd);
      currentX += segment;
    }
  }
  {
    const leftWallLength = (zEnd - 1) - (zStart + 1) + 1;
    const segment = Math.floor(leftWallLength / 3);
    let currentZ = zStart + 1;
    for (let i = 0; i < 3; i++) {
      const wz = currentZ + Math.floor(segment / 2);
      placeVerticalIronBars(xStart, wz);
      currentZ += segment;
    }
  }
  {
    const rightWallLength = (zEnd - 1) - (zStart + 1) + 1;
    const segment = Math.floor(rightWallLength / 3);
    let currentZ = zStart + 1;
    for (let i = 0; i < 3; i++) {
      const wz = currentZ + Math.floor(segment / 2);
      placeVerticalIronBars(xEnd, wz);
      currentZ += segment;
    }
  }
  const roofY = baseY + buildingHeight;
  fillArea(xStart, xEnd,
      zStart, zEnd,
      roofY, 1,
      "minecraft:spruce_planks");
  fillArea(xStart - 1, xEnd + 1,
      zStart - 1, zEnd + 1,
      roofY - 1, 1,
      "minecraft:spruce_planks");
  const width = 20;
  const length = 30;
  const xHalf = width / 2;
  const zHalf = length / 2;
  const castleXStart = Math.floor(castleLocation.x - xHalf);
  const castleXEnd = Math.floor(castleLocation.x + xHalf - 1);
  const castleZStart = Math.floor(castleLocation.z - zHalf);
  const midCastleX = Math.floor((castleXStart + castleXEnd) / 2);
  const pathZStart = castleZStart;
  const pathZEnd = zStart - 1;
  fillArea(midCastleX - 1, midCastleX + 1,
      pathZStart, pathZEnd,
      baseY, 1,
      "minecraft:gravel");
}

function spawnCastleInFrontOfPlayer(player) {
  const width = 20;
  const length = 30;
  const thickness = 2;
  const wallHeight = 5;
  const towerDiameter = 4;
  const towerHeight = 10;
  const moatLength = 8;
  const moatDepth = 3;
  const playerX = Math.floor(player.location.x);
  const playerY = Math.floor(player.location.y);
  const playerZ = Math.floor(player.location.z);
  const offsetLocation = {
    x: playerX,
    y: playerY,
    z: playerZ + Math.floor(length / 2) + 10
  };
  buildCastle(offsetLocation, width, length, thickness, wallHeight,
      towerDiameter, towerHeight);
  buildMoat(offsetLocation, width, length, thickness, moatLength, moatDepth);
  buildBridgeAndGate(offsetLocation, width, length, thickness, moatLength);
  buildInnerBuilding(offsetLocation);
}

world.sendMessage("Script loaded!");
spawnCastleInFrontOfPlayer(world.getPlayers()[0]);