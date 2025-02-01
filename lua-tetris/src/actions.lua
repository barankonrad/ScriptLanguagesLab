local assets = require("assets.assets")

local actions = {}

local shapes = {
    {
        { 1, 1, 1 },
        { 0, 1, 0 },
    },
    {
        { 1, 1 },
        { 1, 1 },
    },
    {
        { 1, 0, 0 },
        { 1, 1, 1 },
    },
    {
        { 0, 0, 1 },
        { 1, 1, 1 },
    },
    {
        { 0, 1, 1 },
        { 1, 1, 0 },
    },
}

function actions.createActiveTetromino(grid)
    local shapeIndex = love.math.random(1, #shapes)
    local shape = shapes[shapeIndex]
    local color = {
        love.math.random(0, 255),
        love.math.random(0, 255),
        love.math.random(0, 255),
    }

    return {
        shape = shape,
        x = math.floor(#grid[1] / 2) - math.floor(#shape[1] / 2),
        y = 1,
        color = color,
        isActive = true
    }
end

function actions.moveTetromino(activeTetromino, grid, dx, dy)
    if actions.canMove(activeTetromino, grid, dx, dy) then
        activeTetromino.x = activeTetromino.x + dx
        activeTetromino.y = activeTetromino.y + dy
    else
        if dy > 0 then
            actions.lockTetromino(activeTetromino, grid)
        end
    end
end

function actions.rotateTetromino(activeTetromino, grid)
    local oldShape = activeTetromino.shape
    local oldRows = #oldShape
    local oldCols = #oldShape[1]

    local newShape = {}
    for row = 1, oldCols do
        newShape[row] = {}
        for col = 1, oldRows do
            newShape[row][col] = oldShape[oldRows - col + 1][row]
        end
    end

    if actions.canRotate(activeTetromino, grid, newShape) then
        activeTetromino.shape = newShape
        assets.audio.rotation:stop()
        assets.audio.rotation:play()
    end
end

function actions.canMove(activeTetromino, grid, dx, dy)
    for y = 1, #activeTetromino.shape do
        for x = 1, #activeTetromino.shape[y] do
            if activeTetromino.shape[y][x] == 1 then
                local newX = activeTetromino.x + x - 1 + dx
                local newY = activeTetromino.y + y - 1 + dy

                if newX < 1 or newX > #grid[1] then
                    return false
                end
                if newY > #grid then
                    return false
                end
                if grid[newY][newX] ~= 0 then
                    return false
                end
            end
        end
    end
    return true
end

function actions.canRotate(activeTetromino, grid, newShape)
    for y = 1, #newShape do
        for x = 1, #newShape[y] do
            if newShape[y][x] == 1 then
                local newX = activeTetromino.x + x - 1
                local newY = activeTetromino.y + y - 1

                if newX < 1 or newX > #grid[1] or newY > #grid then
                    return false
                end
                if grid[newY][newX] ~= 0 then
                    return false
                end
            end
        end
    end
    return true
end

function actions.lockTetromino(activeTetromino, grid)
    for y = 1, #activeTetromino.shape do
        for x = 1, #activeTetromino.shape[y] do
            if activeTetromino.shape[y][x] == 1 then
                local gridX = activeTetromino.x + x - 1
                local gridY = activeTetromino.y + y - 1
                grid[gridY][gridX] = activeTetromino.color

                assets.audio.blockLocked:play()
            end
        end
    end
end

function actions.findFullLines(grid)
    local fullLines = {}
    for y = #grid, 1, -1 do
        local isFull = true
        for x = 1, #grid[y] do
            if grid[y][x] == 0 then
                isFull = false
                break
            end
        end
        if isFull then
            table.insert(fullLines, y)
        end
    end
    return fullLines
end

function actions.createEmptyRow(width)
    local row = {}
    for i = 1, width do
        row[i] = 0
    end
    return row
end

return actions
