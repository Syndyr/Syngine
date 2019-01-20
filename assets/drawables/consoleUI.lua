e.drawQue:addNew("e_consoleUI", "ui", 0, function(dt)
    love.graphics.setBlendMode("alpha")
    love.graphics.clear()
    if e.console then
        local vpBounds = love.window.getDimensions()
        love.graphics.setBackgroundColor({0,0,0,0})
        local I = 0
        local strn = ""
        for I = 0, 10, 1 do
            
            if e.print[#e.print-(I+e.consoleLine)] == nil then break end
            strn = strn..e.print[#e.print-(I+e.consoleLine)][1].."\n"
            
        end
        
        local yOff = e.fonts.arial18:getHeight(strn)*11
        local context = "Lua: \t"..table.concat(e.consoleText)
        
        love.graphics.setColor({64,64,64,200})
        love.graphics.rectangle("fill", v(0,0), v(vpBounds.x, yOff+35))
        love.graphics.rectangle("fill", v(0,yOff+40), v(vpBounds.x, e.fonts.arial18:getHeight(strn)+5 ))
        
        love.graphics.setColor({64,64,64})
        love.graphics.print(context, v(10,yOff+42), 0, v(1,1))
        love.graphics.setColor({255,255,200})
        love.graphics.print(context, v(11,yOff+43), 0, v(1,1))
        
        love.graphics.setColor({255,255,255,128})
        e.olLine(
            {
                0, yOff+30, 
                e.vpBounds.x, yOff+30
            }
        )
        
        love.graphics.setColor({64,64,64})
        love.graphics.print(strn, v(10,10), 0, v(1,1))
        love.graphics.setColor({255,255,200})
        love.graphics.print(strn, v(11,11), 0, v(1,1))
        love.graphics.setColor({255,255,255})
        love.graphics.setCanvas()
        
        love.graphics.setColor({255,255,255,255})
        love.graphics.setBlendMode("alpha")
        
            
        love.graphics.setColor({64,64,64,128})
        love.graphics.rectangle("fill", v(0, e.vpBounds.y-e.fonts.arial18:getHeight(strn)-10), v(e.vpBounds.x, e.fonts.arial18:getHeight(strn)+10))
        
        love.graphics.setColor({255,255,255,128})
        e.olLine(
            {
                0, e.vpBounds.y-e.fonts.arial18:getHeight(strn)-6, 
                e.vpBounds.x, e.vpBounds.y-e.fonts.arial18:getHeight(strn)-6
            }
        )
        
        local context = e.vp:toString(true).."\t|\t"..love.mouse.getPosition():toString(true)
        love.graphics.setColor({64,64,64})
        love.graphics.print(context, v(10,e.vpBounds.y-e.fonts.arial18:getHeight(strn)-2), 0, v(1,1))
        love.graphics.setColor({255,255,200})
        love.graphics.print(context, v(11,e.vpBounds.y-e.fonts.arial18:getHeight(strn)-2), 0, v(1,1))
        
        
        local context = "LOVE version: "..love._version.."\t|\t Syngyn version: "..e._version.."\t|\tFPS: "..love.timer.getFPS().." ("..math.floor(1/love.timer.getAverageDelta())..")"
        love.graphics.setColor({64,64,64})
        love.graphics.print(context, v(e.vpBounds.x-e.fonts.arial18:getWidth(context)-5, e.vpBounds.y-e.fonts.arial18:getHeight(strn)-2), 0, v(1,1))
        love.graphics.setColor({255,255,200})
        love.graphics.print(context, v(e.vpBounds.x-e.fonts.arial18:getWidth(context)-4, e.vpBounds.y-e.fonts.arial18:getHeight(strn)-2), 0, v(1,1))
        love.graphics.setColor({255,255,255,255})
    end
end, true, v(), v(love.window.getDimensions().x, 45+(e.fonts.arial18:getHeight(strn)*12)), true, false)