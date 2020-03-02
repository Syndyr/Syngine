local vpBounds = love.window.getDimensions()
e.ui:createFrame("dev_buttons", 0, e.console, v(0,302), v(250,vpBounds.y-390), false, false)

objectData = {
        centered = false, 
        pos = v(0,0),
        size = v(140, 30),
        data = {
            toggleVar = function()
                
                e.ui.debug = not e.ui.debug
                return e.ui.debug
            
            end,
            checkStat = e.ui.debug
        }
    }
function objectData.data.value()
    local col = {255,0,0}
    if e.ui.debug then col = {0,255,0} end
    return {col, "UI DEBUG"}
end
function objectData.data.doDrawn()
    return e.console
end
e.ui.getFrame("dev_buttons"):add("Check", objectData)

objectData = {
        centered = false, 
        pos = v(0,26),
        size = v(140, 30),
        data = {
            toggleVar = function()
                
                e.test.radiusTest = not e.test.radiusTest
                return e.test.radiusTest
            
            end,
            checkStat = e.test.radiusTest
        }
    }
function objectData.data.value()
    local col = {255,0,0}
    if e.test.radiusTest then col = {0,255,0} end
    return {col, "RADIUS"}
end
function objectData.data.doDrawn()
    return e.console
end
e.ui.getFrame("dev_buttons"):add("Check", objectData)

objectData = {
        centered = false, 
        pos = v(0,52),
        size = v(140, 30),
        data = {
            toggleVar = function()
                
                e.test.flash = not e.test.flash
                return e.test.flash
            
            end,
            checkStat = e.test.flash
        }
    }
function objectData.data.value()
    local col = {255,0,0}
    if e.test.flash then col = {0,255,0} end
    return {col, "FLASH"}
end
function objectData.data.doDrawn()
    return e.console
end
e.ui.getFrame("dev_buttons"):add("Check", objectData)

objectData = {
        centered = false, 
        pos = v(0,78),
        size = v(140, 30),
        data = {
            toggleVar = function()
                
                e.test.bottomBar = not e.test.bottomBar
                return e.test.bottomBar
            
            end,
            checkStat = e.test.bottomBar
        }
    }
function objectData.data.value()
    local col = {255,0,0}
    if e.test.bottomBar then col = {0,255,0} end
    return {col, "INFO"}
end
function objectData.data.doDrawn()
    return e.console
end
e.ui.getFrame("dev_buttons"):add("Check", objectData)


objectData = {
        centered = false, 
        pos = v(0,104),
        size = v(200, 60),
        data = {
            limits = {0, 1000},
            hasSet = true,
            checkStat = e.test.bottomBar
        }
    }
function objectData.data.value()
    return "Movement speed", e.mspeed
end
function objectData.data.doDrawn()
    return e.console
end
function objectData.data.setVar(var)
    e.mspeed = math.floor(var+0.5)
end
e.ui.getFrame("dev_buttons"):add("Slider", objectData)



e.drawQue:addNew("e_consoleUI", "ui", 0, function(dt)
    love.graphics.setBlendMode("alpha")
    --love.graphics.clear()
    vpBounds = love.window.getDimensions()
    local yOff = e.fonts.arial18:getHeight(strn)*11
    local strn = ""
    love.graphics.setFont(e.fonts.arial18)
    love.graphics.setBlendMode("alpha")
    if e.console then
        
        
        local I = 0
        
        for I = 0, 10, 1 do
            
            if e.print[#e.print-(I+e.consoleLine)] == nil then break end
            strn = strn..e.print[#e.print-(I+e.consoleLine)].."\n"
            
        end
        
        
        local context = "Lua: \t"..table.concat(e.consoleText)
        
        love.graphics.setColor({64,64,64,28})
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
    end
        love.graphics.setColor({64,64,64})
        love.graphics.print(strn, v(10,10), 0, v(1,1))
        love.graphics.setColor({255,255,200})
        love.graphics.print(strn, v(11,11), 0, v(1,1))
        love.graphics.setColor({255,255,255})
        
        love.graphics.setColor({255,255,255,255})
        
    if e.test.bottomBar then
        love.graphics.setColor({64,64,64,28})
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
end, true, v(), v(1080,800), true, true)