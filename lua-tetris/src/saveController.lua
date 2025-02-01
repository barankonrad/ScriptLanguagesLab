local saveLoad = {}

local function saveActiveTetromino(tetromino)
    local lines = {}

    table.insert(lines, string.format("%d %d", tetromino.x, tetromino.y))

    table.insert(lines, string.format("%d %d %d",
            tetromino.color[1],
            tetromino.color[2],
            tetromino.color[3]
    ))

    local shapeHeight = #tetromino.shape
    local shapeWidth = #tetromino.shape[1]
    table.insert(lines, string.format("%d %d", shapeHeight, shapeWidth))

    for row = 1, shapeHeight do
        table.insert(lines, table.concat(tetromino.shape[row], ","))
    end

    return lines
end

local function saveGrid(grid)
    local lines = {}

    for y = 1, #grid do
        local rowItems = {}
        for x = 1, #grid[y] do
            local cell = grid[y][x]
            if cell == 0 then
                table.insert(rowItems, "0")
            else
                table.insert(rowItems, string.format("(%d,%d,%d)",
                        cell[1], cell[2], cell[3]
                ))
            end
        end
        table.insert(lines, table.concat(rowItems, " "))
    end

    return lines
end

local function loadActiveTetromino(lines, startIndex)
    local xStr, yStr = lines[startIndex]:match("^(%d+)%s+(%d+)$")
    if not xStr or not yStr then
        return nil, nil
    end
    local tX = tonumber(xStr)
    local tY = tonumber(yStr)

    local rStr, gStr, bStr = lines[startIndex + 1]:match("^(%d+)%s+(%d+)%s+(%d+)$")
    if not (rStr and gStr and bStr) then
        return nil, nil
    end
    local r = tonumber(rStr)
    local g = tonumber(gStr)
    local b = tonumber(bStr)

    local heightString, widthString = lines[startIndex + 2]:match("^(%d+)%s+(%d+)$")
    if not heightString or not widthString then
        return nil, nil
    end
    local shape = tonumber(heightString)

    local shapeLines = {}
    local currentIndex = startIndex + 3
    for _ = 1, shape do
        local rowTable = {}
        for val in lines[currentIndex]:gmatch("([^,]+)") do
            table.insert(rowTable, tonumber(val))
        end
        table.insert(shapeLines, rowTable)
        currentIndex = currentIndex + 1
    end

    local loadedTetromino = {
        x = tX,
        y = tY,
        color = { r, g, b },
        shape = shapeLines,
        isActive = true
    }

    return loadedTetromino, currentIndex
end

local function loadGrid(lines, startIndex)
    local loadedGrid = {}
    local rowIndex = 1
    local line = startIndex

    while line <= #lines do
        local lineStr = lines[line]
        if lineStr == "" then
            break
        end
        loadedGrid[rowIndex] = {}

        local colIndex = 1
        for part in lineStr:gmatch("([^%s]+)") do
            if part == "0" then
                loadedGrid[rowIndex][colIndex] = 0
            else
                local r, g, b = part:match("^%((%d+),(%d+),(%d+)%)$")
                if r and g and b then
                    loadedGrid[rowIndex][colIndex] = {
                        tonumber(r),
                        tonumber(g),
                        tonumber(b)
                    }
                else
                    return nil, nil
                end
            end
            colIndex = colIndex + 1
        end

        line = line + 1
        rowIndex = rowIndex + 1
    end

    return loadedGrid, line
end

function saveLoad.saveGame(grid, tetromino)
    local allLines = {}

    local tetrominoLines = saveActiveTetromino(tetromino)
    for _, line in ipairs(tetrominoLines) do
        table.insert(allLines, line)
    end

    local gridLines = saveGrid(grid)
    for _, line in ipairs(gridLines) do
        table.insert(allLines, line)
    end

    local fileContent = table.concat(allLines, "\n")
    love.filesystem.write("my_save.txt", fileContent)
end

function saveLoad.loadGame()
    local info = love.filesystem.getInfo("my_save.txt")
    if not info then
        return nil, nil
    end

    local content = love.filesystem.read("my_save.txt")
    if not content then
        return nil, nil
    end

    local lines = {}
    for line in content:gmatch("([^\n]*)\n?") do
        table.insert(lines, line)
    end

    if #lines < 4 then
        return nil, nil
    end

    local loadedTetromino, nextIndex = loadActiveTetromino(lines, 1)
    if not loadedTetromino then
        return nil, nil
    end

    local loadedGrid, _ = loadGrid(lines, nextIndex)
    if not loadedGrid then
        return nil, nil
    end

    return loadedGrid, loadedTetromino
end

return saveLoad
