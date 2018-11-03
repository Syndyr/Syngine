function l.load()
    require "errorOverride"
    dt = 0
    oldprint = print
    --debug = true
    lfs = "love.main"
    g = {}
    e = {print = {}, console = false, consoleTyping = false, consoleText = {}, consoleLine = 0, font = love.graphics.newFont(12)}
    function print(s)
        if s == nil then s = "nil" end
        if type(s) ~= "string" then s = tostring(s) end
        oldprint('['..lfs..'] : '..s.."\t")
        --if not debug then return false end
        e.print[#e.print+1] = {'['..lfs..'] : '..s.."\t"}
    end
    libraries = {}
    libraries[1] = {
        "math",
        "vector",
        "serial"
    }
    libraries[2] = {
        "string",
        "table",
        "class",
        "timer"
    }
    libraries[3] = {
        "map"
    --    "main"
    }
    libraries[4] = {
        "loveVec",
        "assets"
    --    "keypress",
    --    "ui"
    }
    function reloadLibraries()
        for k,v in pairs(libraries) do
            for n,b in pairs(v) do
                local st = l.timer.getTime()
                print("Impoting library : ".."libs."..b.."....")
                lfs = "libs."..b
                require("libs."..b)
                lfs = "love.main"
                print("Done ("..math.round(((l.timer.getTime()-st)*1000), 4).."ms)")
                print("----------")
                print("")
            end
        end
    end
    reloadLibraries()
    g.vp = Vector(0,0)
    function drawque()
        for k,v in pairs(draw.drawque) do
            if type(v) ~= "function" and drawqueIndexBlacklist[k] == nil then
                print("Attempted to draw a non function object via drawquee")
                print(k..[["]]..type(v)..[["]])
                print("Item added to the Index Blacklist.")
                drawqueIndexBlacklist[k] = true
            else
                if drawqueIndexBlacklist[k] == nil then
                    v(dt)
                end
            end
        end
    end
    
    draw = {drawque = setmetatable({}, {__call = drawque})}
    drawqueIndexBlacklist = {}
    
    draw.drawque["e_console"] = function(dt)
        if e.console then
            local I = 0
            local strn = ""
            for I = 0, 10, 1 do
                
                if e.print[#e.print-(I+e.consoleLine)] == nil then break end
                strn = strn..e.print[#e.print-(I+e.consoleLine)][1].."\n"
                
            end
            local yOff = e.font:getHeight(strn)*10
            local context = "/>\t("..(table.concat(e.consoleText) or "Lua")..")"
            
            love.graphics.setColor({64,64,64,64})
            love.graphics.rectangle("fill", v(0,0), v(99999, yOff+35))
            
            love.graphics.rectangle("fill", v(0,yOff+40), v(99999, e.font:getHeight(strn)+5 ))
            
            love.graphics.setColor({64,64,64})
            love.graphics.print(context, v(10,yOff+42), 0, v(1,1))
            love.graphics.setColor({255,255,200})
            love.graphics.print(context, v(11,yOff+43), 0, v(1,1))
            
            love.graphics.setColor({255,255,255,128})
            olLine(
                {
                    0, yOff+30, 
                    99999, yOff+30
                }
            )
            
            
            love.graphics.setColor({64,64,64})
            love.graphics.print(strn, v(10,10), 0, v(1,1))
            love.graphics.setColor({255,255,200})
            love.graphics.print(strn, v(11,11), 0, v(1,1))
            
        end
    end
    
    love.graphics.setBackgroundColor(180,215,245)
    g.mspeed = 10
    seed = string.toSeed("a")
end

function l.draw()
    draw.drawque()
    drawque()
    s.timerRT(dt)
    --draw["e_console"]()
    --tempTileTest()
end

function l.update(dt)
    dt = dt
    --wave = wave + (dt*0.1)
    s.timerRT()
    if love.keyboard.isDown("s") then g.vp.y = g.vp.y-(g.mspeed*dt) end
    if love.keyboard.isDown("d") then g.vp.x = g.vp.x-(g.mspeed*dt) end
    if love.keyboard.isDown("w") then g.vp.y = g.vp.y+(g.mspeed*dt) end
    if love.keyboard.isDown("a") then g.vp.x = g.vp.x+(g.mspeed*dt) end
    
    
end

function l.focus(bool)
end

function love.textinput(t)
    if e.consoleTyping and t ~= "`" then
        e.consoleText[#e.consoleText+1] = t
    end
end

function l.keypressed( key, unicode )
    if e.console then 
        if key == "return" then
            local func = loadstring(table.concat(e.consoleText)) or function() print("???") end
            xpcall(func, debug.traceback)
            e.consoleText = {}
        end
        if key == "backspace" then
            table.remove(e.consoleText, #e.consoleText)
        end
    end
    if key == "`" then 
        e.console = not e.console 
        e.consoleTyping = e.console
        e.consoleText = {}
        --print(tostring(g.console))
    end
end

function l.keyreleased( key, unicode )
	
end

function l.mousepressed( x, y, button )
    --print(button)
    
    if button == "wu" then
        if (e.consoleLine + 1) >  (#e.print - 10) then return false end
        e.consoleLine = e.consoleLine + 1
    end
    if button == "wd" then
        if e.consoleLine - 1 < 0 then return false end
        e.consoleLine = e.consoleLine - 1
    end
    --[[
    if button == "l" then
        if tempTileArray[curTile.y] ~= nil then 
            if tempTileArray[curTile.y][curTile.x] == nil then return false end
            if tempTileArray[curTile.y][curTile.x].level + 1 < 5 then
                tempTileArray[curTile.y][curTile.x].level = tempTileArray[curTile.y][curTile.x].level +1
            else
                tempTileArray[curTile.y][curTile.x].level = 1
            end
            smoothTiles()
        end
    end
    if button == "r" then
        if tempTileArray[curTile.y] ~= nil then 
            if tempTileArray[curTile.y][curTile.x] == nil then return false end
            if tempTileArray[curTile.y][curTile.x].level - 1 > 0 then
                tempTileArray[curTile.y][curTile.x].level = tempTileArray[curTile.y][curTile.x].level - 1
            else
                tempTileArray[curTile.y][curTile.x].level = 4
            end
            smoothTiles()
        end
    end
    ]]--
end

function l.mousereleased( x, y, button )
end

function l.quit()
    if love.filesystem.exists("log.txt") ~= true then
        love.filesystem.write("log.txt", "\n", string.len("\n"))
    end
    local str = ""
    for k,v in pairs(e.print) do 
        str = str.."\n"..v[1]
    end
    love.filesystem.append("log.txt", "\n_______________________________________\n\n"..os.date("%d_%m_%y_%H%M").."\n\n_______________________________________\n\n", str:len())
    love.filesystem.append("log.txt", str, str:len())
end