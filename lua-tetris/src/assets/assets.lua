local assets = {
    image = {
        block = love.graphics.newImage("assets/image/block.png"),
        play = love.graphics.newImage("assets/image/play.png"),
        save = love.graphics.newImage("assets/image/save.png"),
        load = love.graphics.newImage("assets/image/load.png")
    },
    audio = {
        rotation = love.audio.newSource("assets/audio/rotation.mp3", "static"),
        clearedRow = love.audio.newSource("assets/audio/clearedRow.mp3", "static"),
        blockLocked = love.audio.newSource("assets/audio/blockLocked.mp3", "static"),
        gameOver = love.audio.newSource("assets/audio/gameOver.mp3", "static")
    }
}
return assets