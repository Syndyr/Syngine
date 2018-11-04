function l.load()
    require "errorOverride"
    --Override the default Love2D error handler
    
    dt = 0
    --Globalise the Delta Time passed from love.update
    
    oldprint = print
    --Transport print to a different function as we want to hook into it
    
    function print(s)
        --We're making our own print function so it hooks into the console
        if s == nil then s = "nil" end
        if type(s) ~= "string" then s = tostring(s) end
        --Some simple input sanitisation 
        local strn = '['..os.date("%H:%M:%S")..']['..lfs..'] : '..s
        oldprint(strn)
        --Do a classic print
        
        e.print[#e.print+1] = {strn}
        --Add the print to the print array
    end
    lfs = "love.main"
    --[[
        Last File String, for tracking where a print comes from.
        Sadly Lua doesn't allow for a dynamic method of doing this
        so it has to be set manually.
        love.<filename> for anything in the root folder
        <folderName>.<filename> for anything in child folders 
    ]]--
    
    e = {
        print = {}, 
        console = false, 
        consoleTyping = false, 
        consoleText = {}, 
        consoleLine = 0, 
        font = love.graphics.newFont(12),
        libraries = {
            {
                "math",
                "vector",
                "serial"
            },{
                "string",
                "table",
                "class",
                "timer"
            },{
                "map"
            --    "main"
            },{
                "loveVec",
                "assets"
            --    "keypress",
            --    "ui"
            }
        }
    }
    --This is the engine table, all functions should go here.
    --Also functions as a lookup table for the game table
    --Allowing for me to be lazy.
    
    g = setmetatable({}, {__index = e})
    --This is the game table, any game specific data goes here.
    --Only data, no functions.
    
    function reloadLibraries()
        for k,v in pairs(e.libraries) do
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
    --A function for loading and reloading the default libraries
    
    g.vp = Vector(0,0)
    --Has to be set after the vector library is loaded or bad you'll have a bad day
    
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
    --Simple draw que function, allows for dynamically adding items to a draw que
    
    draw = {drawque = setmetatable({}, {__call = drawque})}
    --Black magic metatable voodoo
    
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
    --Console drawing
    
    love.graphics.setBackgroundColor(180,215,245)
    g.mspeed = 10
    seed = string.toSeed("a")
    --Misc stuff
end

function l.draw()
    draw.drawque()
    s.timerRT(dt)
end

function l.update(dt)
    dt = dt
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
    end
end

function l.keyreleased( key, unicode )
	
end

function l.mousepressed( x, y, button )
    if button == "wu" then
        if (e.consoleLine + 1) >  (#e.print - 10) then return false end
        e.consoleLine = e.consoleLine + 1
    end
    if button == "wd" then
        if e.consoleLine - 1 < 0 then return false end
        e.consoleLine = e.consoleLine - 1
    end
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