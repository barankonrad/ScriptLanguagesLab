local assets = require("assets.assets")

local grid = {}

function grid.createGrid(width, height)
    local gameGrid = {}
    for y = 1, height do
        gameGrid[y] = {}
        for x = 1, width do
            gameGrid[y][x] = 0
        end
    end
    return gameGrid
end

function grid.drawGrid(gameGrid, cellSize)
    for y = 1, #gameGrid do
        for x = 1, #gameGrid[y] do

            if gameGrid[y][x] ~= 0 then
                local rgb = gameGrid[y][x]
                love.graphics.setColor(love.math.colorFromBytes(rgb[1], rgb[2], rgb[3])
                )
            else
                love.graphics.setColor(1, 1, 1, 1)
            end

            love.graphics.draw(
                    assets.image.block,
                    (x - 1) * cellSize,
                    (y - 1) * cellSize,
                    0,
                    cellSize / assets.image.block:getWidth(),
                    cellSize / assets.image.block:getHeight()
            )
        end
    end
end

function grid.drawTetromino(activeTetromino, cellSize)
    if not activeTetromino then
        return
    end

    local rgb = activeTetromino.color or { 255, 255, 255 }
    love.graphics.setColor(love.math.colorFromBytes(rgb[1], rgb[2], rgb[3]))

    for row = 1, #activeTetromino.shape do
        for col = 1, #activeTetromino.shape[row] do
            if activeTetromino.shape[row][col] == 1 then
                local drawX = (activeTetromino.x + col - 2) * cellSize
                local drawY = (activeTetromino.y + row - 2) * cellSize

                love.graphics.draw(
                        assets.image.block,
                        drawX,
                        drawY,
                        0,
                        cellSize / assets.image.block:getWidth(),
                        cellSize / assets.image.block:getHeight()
                )
            end
        end
    end
end

return grid
