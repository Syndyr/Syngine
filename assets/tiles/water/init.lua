local image = {}

image.filename = "water"
image.name = "watersheet"
image.tile = false
image.alpha = true
image.trims = "none"
image.tiles = {
    love.graphics.newQuad(v(), v(1920,1080), 2048, 2048),
    love.graphics.newQuad(v(1984,0), v(64,64), 2048, 2048),
    love.graphics.newQuad(v(1984,64), v(64,64), 2048, 2048)
}

return image