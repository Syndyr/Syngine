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
    
    local iHat = self.iHat
    local jHat = self.jHat
    local size = self.size
    
    local a = iHat.x * size.x
    local b = jHat.x * size.x
    local c = iHat.y * size.y
    local d = jHat.y * size.y 
    
    
    local inver = invertMatrix(a,b,c,d)
    
    
    return v( 
        screenCoordinate.x * inver.a + screenCoordinate.y * inver.b, 
        screenCoordinate.x * inver.c + screenCoordinate.y * inver.d
    )
end

t.testTiles = t:createTilePositions(32,32)

function t:testingDraw()
    
    local VPOffset = e.vp
    local tiles = self.testTiles
    local tile = self.tileMesh
    for k,v in pairs(tiles) do
        
        for n,b in pairs(v) do
            
            love.graphics.setColor(255,255,255,20)
            
            local mpos = love.mouse.getPosition()
            --:inBounds2D(b, p)
            local mposInWorldSpace = self:getWorldCoordinate(VPOffset-mpos)
            
            local mx, my = math.floor(mposInWorldSpace.x + 1.5)*-1,math.floor(mposInWorldSpace.y + 0.5)*-1
            
            if mx == k and my == n then love.graphics.setColor(255,0,0,20) end 
            
            --e.olDraw(tile, mposInWorldSpace.x, mposInWorldSpace.y)
            
            local pos = b * self.size
            e.olDraw(tile, pos.x+VPOffset.x, pos.y+VPOffset.y)
            
            love.graphics.setColor(255,0,0,255)
            e.olgPrint(k..","..n, pos.x+VPOffset.x, pos.y+VPOffset.y)
            e.olgPrint(mx..","..my, mpos.x, mpos.y-10)
            
        end
        
    end
    
end

return t