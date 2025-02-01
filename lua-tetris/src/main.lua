local assets = require("assets.assets")
local grid = require("layout.grid")
local buttons = require("layout.buttons")
local actions = require("actions")
local saveControl = require("saveController")

local isGameOn = false
local isGameOver = false

local gridWidth, gridHeight, cellSize = 10, 20, 35
local gameGrid = {}
local activeTetromino

local dropTimer, dropInterval = 0, 0.5

local myButtons = {}
local buttonCount = 3
local buttonSize = 50
local buttonSpacing = 10
local buttonYOffset = 20

local clearingAnimationActive = false
local linesToClear = {}
local clearColumn = 1
local clearTimer = 0
local clearSpeed = 0.05

local function startGame()
    activeTetromino = actions.createActiveTetromino(gameGrid)
    isGameOn = true
end

local function endGame()
    assets.audio.gameOver:stop()
    assets.audio.gameOver:play()
    isGameOver = true
end

local function startLineClearingAnimation(fullLines)
    clearingAnimationActive = true
    linesToClear = fullLines
    clearColumn = 1
    clearTimer = 0

    assets.audio.clearedRow:stop()
    assets.audio.clearedRow:play()
end

local function finishLineClearingAnimation()
    for _, rowIndex in ipairs(linesToClear) do
        for x = 1, #gameGrid[rowIndex] do
            gameGrid[rowIndex][x] = 0
        end
    end

    table.sort(linesToClear)
    for i = 1, #linesToClear do
        local rowIndex = linesToClear[i]
        table.remove(gameGrid, rowIndex)
        table.insert(gameGrid, 1, actions.createEmptyRow(#gameGrid[1]))
    end

    clearingAnimationActive = false
    linesToClear = {}
    clearColumn = 1
    clearTimer = 0

    activeTetromino = actions.createActiveTetromino(gameGrid)
    if not actions.canMove(activeTetromino, gameGrid, 0, 0) then
        endGame()
    end
end

local function handleAnimation(timer)
    if clearingAnimationActive then
        clearTimer = clearTimer + timer
        if clearTimer >= clearSpeed then
            clearTimer = clearTimer - clearSpeed

            for _, rowIndex in ipairs(linesToClear) do
                if gameGrid[rowIndex][clearColumn] ~= nil then
                    gameGrid[rowIndex][clearColumn] = 0
                end
            end

            clearColumn = clearColumn + 1
            if clearColumn > #gameGrid[1] then
                finishLineClearingAnimation()
            end
        end
        return
    end
end

function love.load()
    love.window.setTitle("Tetris")
    local extraSpace = 150
    local totalWidth = gridWidth * cellSize
    local totalHeight = gridHeight * cellSize + extraSpace
    love.window.setMode(totalWidth, totalHeight)

    gameGrid = grid.createGrid(gridWidth, gridHeight)

    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()
    myButtons = buttons.createButtons(
            buttonCount,
            buttonSize,
            buttonSpacing,
            screenWidth,
            screenHeight,
            buttonYOffset
    )
end

local function handleTetrominoMovement(timer)
    dropTimer = dropTimer + timer
    if dropTimer >= dropInterval then
        dropTimer = 0
        if not actions.canMove(activeTetromino, gameGrid, 0, 1) then
            actions.lockTetromino(activeTetromino, gameGrid)
            local fullLines = actions.findFullLines(gameGrid)
            if #fullLines > 0 then
                startLineClearingAnimation(fullLines)
            else
                activeTetromino = actions.createActiveTetromino(gameGrid)
                if not actions.canMove(activeTetromino, gameGrid, 0, 0) then
                    endGame()
                end
            end
        else
            actions.moveTetromino(activeTetromino, gameGrid, 0, 1)
        end
    end
end

function love.update(timer)
    if not isGameOn or isGameOver then
        return
    end

    handleAnimation(timer)
    handleTetrominoMovement(timer)
end

function love.keypressed(key)
    if isGameOver then
        return
    end

    if isGameOn and not clearingAnimationActive then
        if key == "left" then
            actions.moveTetromino(activeTetromino, gameGrid, -1, 0)
        elseif key == "right" then
            actions.moveTetromino(activeTetromino, gameGrid, 1, 0)
        elseif key == "down" then
            actions.moveTetromino(activeTetromino, gameGrid, 0, 1)
        elseif key == "space" then
            actions.rotateTetromino(activeTetromino, gameGrid)
        end
    else
        if (not isGameOn) and key == "space" then
            startGame()
        end
    end

    if key == "escape" then
        love.event.quit()
    end
end

function love.draw()
    love.graphics.clear(1, 1, 1)
    grid.drawGrid(gameGrid, cellSize)
    grid.drawTetromino(activeTetromino, cellSize)
    buttons.drawButtons(myButtons, buttonSize)
end

function love.mousepressed(x, y, button)
    if isGameOver then
        return
    end

    if button == 1 then
        for i, btn in ipairs(myButtons) do
            if x >= btn.x and x <= (btn.x + buttonSize) and
                    y >= btn.y and y <= (btn.y + buttonSize) then
                if i == 1 then
                    if not isGameOn then
                        startGame()
                    end
                elseif i == 2 then
                    if isGameOn then
                        saveControl.saveGame(gameGrid, activeTetromino)
                    end
                elseif i == 3 then
                    if not isGameOn then
                        local loadedGrid, loadedActiveTetromino = saveControl.loadGame()
                        if loadedGrid and loadedActiveTetromino then
                            gameGrid = loadedGrid
                            activeTetromino = loadedActiveTetromino
                            isGameOn = true
                        end
                    end
                end
            end
        end
    end
end
