local t = {
    __title = "Isometric tile library",
    __description = "Provides isometric tile rendering",
    __author = "Connor Day",
    __version = 1,
    iHat = v(0.5, 0.5),
    jHat = v(-0.5, 0.5),
    size = v(128,64),
}

t.points = {
    t.size * v(0.5, 0),
    t.size * v(1, 0.5),
    t.size * v(0.5, 1),
    t.size * v(0, 0.5)
}

t.uvs = {
    v(0, 0),
    v(1, 0),
    v(1, 1),
    v(0, 1)
}

t.tileMesh = love.graphics.newMesh(
    {
        {t.points[1].x, t.points[1].y, t.uvs[1].x, t.uvs[1].y, 1, 1, 1, 1},
        {t.points[2].x, t.points[2].y, t.uvs[2].x, t.uvs[2].y, 1, 1, 1, 1},
        {t.points[3].x, t.points[3].y, t.uvs[3].x, t.uvs[3].y, 1, 1, 1, 1},
        {t.points[4].x, t.points[4].y, t.uvs[4].x, t.uvs[4].y, 1, 1, 1, 1}
    }, 
    "fan", 
    "static"
)
t.aspectRatio = t.size.x/t.size.y

function t:getScreenCoordinate(worldCoordinate)
    
    local iHat = self.iHat
    local jHat = self.jHat
    local x = worldCoordinate.x * iHat.x + worldCoordinate.y * jHat.x
    local y = worldCoordinate.x * iHat.y + worldCoordinate.y * jHat.y
    
    local worldPos = v(x,y)
    return worldPos
end

function t:createTilePositions(xLim, yLim)
    
    local tilePositions = {}
    local iX = 0
    local size = self.size
    
    for iX = 0, xLim do
        
        tilePositions[iX] = {}
        local iY = 0
        
        for iY = 0, yLim do
            
            local pos = t:getScreenCoordinate( v(iX, iY))
            tilePositions[iX][iY] = pos
            
        end
    end
    
    return tilePositions
    
end

local function invertMatrix(a,b,c,d)
    local det = 1 / (a * d - b * c)
    
    return { 
        a = det * d, 
        b = det * -b, 
        c = det * -c, 
        d = det * a
    }
end

function t:getWorldCoordinate(screenCoordinate)
    
    --Invert matrix
    local screenCoordinate = e.vp - screenCoordinate

    local iHat = self.iHat
    local jHat = self.jHat
    local size = self.size
    
    local a = iHat.x * size.x
    local b = jHat.x * size.x
    local c = iHat.y * size.y
    local d = jHat.y * size.y 
    
    
    local inver = invertMatrix(a,b,c,d)
    
    
    return v( 
        (((screenCoordinate.x * inver.a +  screenCoordinate.y * inver.b) + 0.5 ) * -1)*64, 
        (((screenCoordinate.x * inver.c +  screenCoordinate.y * inver.d) - 0.5) * -1)*64
    )
end

function t:getTileCoordinateFromScreenPosition(pos)

    return self:getWorldCoordinate(pos) / 64

end

t.testTiles = t:createTilePositions(512,512)

function t:testingDraw()
    
    local VPOffset = e.vp
    local tiles = self.testTiles
    local tile = self.tileMesh

    local mpos = love.mouse.getPosition()
    local mposInWorldSpace = self:getWorldCoordinate( mpos)
            
    local mx, my = mposInWorldSpace.x, mposInWorldSpace.y
    local mosTile = self:getTileCoordinateFromScreenPosition( mpos )

    love.graphics.setColor(255,0,0,255)

    local inCullAmount = 0
    local bottomRight = self:getTileCoordinateFromScreenPosition(v(love.graphics.getDimensions() )) - inCullAmount
    local bottomLeft = self:getTileCoordinateFromScreenPosition(v(love.graphics.getDimensions() ) * v(0,1)) - inCullAmount
    local topRight = self:getTileCoordinateFromScreenPosition(v(love.graphics.getDimensions() ) * v(1,0)) + inCullAmount
    local topLeft = self:getTileCoordinateFromScreenPosition(v()) + inCullAmount


    e.olgPrint(mosTile.x..","..mosTile.y, mpos.x, mpos.y-20)
    
    local x = math.floor(math.max(0, topLeft.x))

    local xLim = math.floor(math.min(#tiles, bottomRight.x))
    e.oldprint(#tiles, bottomRight.x)
    for x = x, xLim do 
        local yLim = math.floor(math.min(#tiles[x], bottomLeft.y))
        local y = math.floor(math.max(0, topRight.y))

        for y=y, yLim do
            
            love.graphics.setColor(255,255,255,20)
            
            
            if math.floor(mosTile.x) == x and math.floor(mosTile.y) == y then love.graphics.setColor(255,0,0,20) end 
            
            local pos = tiles[x][y] * self.size
            e.olDraw(tile, pos.x+VPOffset.x, pos.y+VPOffset.y)

        end

    end 
    --[[
    for k,v in pairs(tiles) do
        
        for n,b in pairs(v) do
            
            love.graphics.setColor(255,255,255,20)
            
            
            if math.floor(mosTile.x) == k and math.floor(mosTile.y) == n then love.graphics.setColor(255,0,0,20) end 
            
            local pos = b * self.size
            e.olDraw(tile, pos.x+VPOffset.x, pos.y+VPOffset.y)
            
            
        end
        
    end
    ]]--
    
end

return t