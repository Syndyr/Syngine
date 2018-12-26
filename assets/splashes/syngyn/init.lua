local image = {}

image.filename = "syngyn"
image.name = "engine_splash"
image.type = "image"
image.tile = false
image.alpha = true
image.trims = "none"
image.tiles = {
    engine_default = love.graphics.newQuad(v(0, 132), v(1024,178), 1024, 512),
    engine_noGame = love.graphics.newQuad(v(0,325), v(1024,75), 1024, 512),
    engine_combined = love.graphics.newQuad(v(0,132), v(1024,268), 1024, 512)
}

return image