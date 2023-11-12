local t = {
    size = v(128,64)
}

function t:makeNewTileMap(tileType, size)
    tileType = tileType == nil and "base" or tileType

    
    local dictionary = self.tileDictionary
    local baseTile = dictionary.baseTile
    local baseSum = 42
    self.tiles = {positions = e.isoTile:createTilePositions(size)}

    local formattedTiles = {}

    for x, yv in pairs(self.tiles.positions) do

        formattedTiles[x] = {}

        for y, tile in pairs(yv) do
            
            formattedTiles[x][y] = {
                position = tile,
                tile = {
                    base = "water", 
                    sum = 42
                }
            }

        end
    end

    self.tiles = formattedTiles

    

end

function t:draw(dt)

    
    local isoLib = e.isoTile

    local VPOffset = e.vp
    local dictionary = self.tileDictionary.tileDictionary
    local image = self.tileDictionary.image
    local tiles = self.tiles
    
    local mpos = love.mouse.getPosition()
    local mosTile = isoLib:getTileCoordinateFromScreenPosition( mpos )

    love.graphics.setColor(255,0,0,255)

    local inCullAmount = 0
    local bottomRight = isoLib:getTileCoordinateFromScreenPosition(v(love.graphics.getDimensions() )) - inCullAmount
    local bottomLeft = isoLib:getTileCoordinateFromScreenPosition(v(love.graphics.getDimensions() ) * v(0,1)) - inCullAmount
    local topRight = isoLib:getTileCoordinateFromScreenPosition(v(love.graphics.getDimensions() ) * v(1,0)) + inCullAmount
    local topLeft = isoLib:getTileCoordinateFromScreenPosition(v()) + inCullAmount

    

    
    
    local x = math.floor(math.max(0, topLeft.x))

    local xLim = math.floor(math.min(#tiles, bottomRight.x))
    --e.oldprint(#tiles, bottomRight.x)
    for x = x, xLim do 
        local yLim = math.floor(math.min(#tiles[x], bottomLeft.y))
        local y = math.floor(math.max(0, topRight.y))

        for y=y, yLim do
            local tile = tiles[x][y]


            local tileMesh = dictionary:getTile(tile.tile.base, tile.tile.sum)
            love.graphics.setColor(255,255,255,255)
            
            if math.floor(mosTile.x) == x and math.floor(mosTile.y) == y then
                 love.graphics.setColor(255,0,0,255) 
                 tileMesh = dictionary:getTile("grass", 42)
            end 
            
            local pos = tile.position * self.size
            e.olDraw(tileMesh.mesh.mesh, pos.x+VPOffset.x, pos.y+VPOffset.y-32, 0, 1, 1, 0, 0)
            e.olgPrint(tile.tile.sum, pos.x+VPOffset.x+64, pos.y+VPOffset.y+32)
        end

    end 

    e.olgPrint(mosTile.x..","..mosTile.y, mpos.x, mpos.y-20)

end

return t