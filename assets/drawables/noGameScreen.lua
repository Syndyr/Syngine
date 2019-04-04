e.drawQue:addNew("e_noGameScreen", "other", 0, function(dt)
    love.graphics.setBlendMode("alpha")
    love.graphics.clear()
    local vpBounds = love.window.getDimensions()
    local vp = e.vp or v()
    local fade = 0 or e.introFade
    love.graphics.setBackgroundColor({0,0,0,0})
    love.graphics.setColor(255,255,255)
    local xOff, yOff = (vp%64):splitxyz()
    local xLim, yLim = (vpBounds/64):splitxyz(true)
    local x,y = -1, -1
    local drawMe = e.asset:get("image", "noTex")
    for x = -1, math.floor(xLim+0.5), 1 do
        local rX, rY = (x*64)+xOff, (y*64)+yOff
        for y = -1, math.floor(yLim+0.5), 1 do
            rY = (y*64)+yOff
            e.olDraw(drawMe.image, rX, rY)
        end
    end
        
    if not e.test.flash then return false end
    local splash = e.asset:get("image", "engine_splash")
    
    e.olDraw(splash.image, splash.tiles.engine_default, (vpBounds.x/2)-512, (vpBounds.y/2)-89)
        
    if e.noGameFlash then
        e.olDraw(splash.image, splash.tiles.engine_noGame, (vpBounds.x/2)-512, (vpBounds.y/2)+89)
    end
    
end, true, v(), v(love.window.getDimensions().x, love.window.getDimensions().y), true, true)