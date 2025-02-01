local assets = require("assets.assets")
local colors = require("layout.colors")

local buttons = {}

function buttons.createButtons(buttonCount, buttonSize, buttonSpacing, screenWidth, screenHeight, buttonYOffset)
    local totalWidth = buttonCount * buttonSize + (buttonCount - 1) * buttonSpacing
    local buttonStartX = (screenWidth - totalWidth) / 2
    local buttonY = screenHeight - buttonSize - buttonYOffset

    local buttonList = {}
    for i = 1, buttonCount do
        table.insert(buttonList, {
            x = buttonStartX + (i - 1) * (buttonSize + buttonSpacing),
            y = buttonY,
            color = colors.button or { 128, 128, 128 }
        })
    end
    return buttonList
end

local function drawButtonWithImage(image, x, y, buttonSize)
    love.graphics.draw(
            image,
            x,
            y,
            0,
            buttonSize / image:getWidth(),
            buttonSize / image:getHeight()
    )
end

function buttons.drawButtons(buttonList, buttonSize)
    for i, button in ipairs(buttonList) do
        love.graphics.setColor(1, 1, 1)
        drawButtonWithImage(assets.image.block, button.x, button.y, buttonSize)

        if i == 1 then
            love.graphics.setColor(0, 0, 0)
            drawButtonWithImage(assets.image.play, button.x, button.y, buttonSize)
        elseif i == 2 then
            love.graphics.setColor(0, 0, 0)
            drawButtonWithImage(assets.image.save, button.x, button.y, buttonSize)
        elseif i == 3 then
            love.graphics.setColor(0, 0, 0)
            drawButtonWithImage(assets.image.load, button.x, button.y, buttonSize)
        end
    end
    love.graphics.setColor(1, 1, 1)
end

return buttons
