function love.load()
    require "errorOverride"
    --Override the default Love2D error handler
    
    e = {
        print = {}, 
        _version = "0.1.0",
        console = false, 
        consoleTyping = false, 
        consoleText = {}, 
        consoleLine = 0, 
        debug = true,
        dt = 0,
        font = love.graphics.newFont(12),
        doDraw = true,
        mspeed = 500,
        introFade = 255,
        noGameFlash = false,
        manifest = require "engine.manifest"
    }
    
    --This is the engine table, all functions should go here.
    --Also functions as a lookup table for the game table
    --Allowing for me to be lazy.
    
    e.oldprint = print
    --Transport print to a different function as we want to hook into it
    
    function print(s)
        --We're making our own print function so it hooks into the console
        if s == nil then s = "nil" end
        if type(s) ~= "string" then s = tostring(s) end
        --Some simple input sanitisation 
        local strn = '['..os.date("%H:%M:%S")..']['..lfs..'] : '..s
        e.oldprint(strn)
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
    
    
    
    g = setmetatable({
    }, {__index = e})
    --This is the game table, any game specific data goes here.
    --Only data, no functions.
    
    function e.loadItemsFromManifest()
        local startTime = love.timer.getTime()*1000
        for k,v in pairs(e.manifest.libraries) do
            for n,b in pairs(v) do
                
                local st = l.timer.getTime()
                
                print("Impoting library : ".."libs."..b.."....")
                
                lfs = "libs."..b
                
                require("libs."..b)
                
                lfs = "love.main"
                
                print("Done ("..e.math.round(((l.timer.getTime()-st)*1000), 4).."ms)")
                print("----------")
                print("")
            end
        end
        print("Loading bases..")
        print("")
        print("----------")
        print("")
        for k,v in pairs(e.manifest.bases) do
            print("Importing base: "..v[1].." from domain: "..v[2])
            e.class.getBase(v[1], v[2])
        end
        print("")
        print("----------")
        print("")
        print("Bases loaded.")
        print("Loading assets..")
        print("")
        print("----------")
        print("")
        for k,v in pairs(e.manifest.assets) do
            print("Getting asset: "..v)
            e.asset:load(v)
        end
        print("Fully loaded in "..(love.timer.getTime()*1000)-startTime.."ms")
        e.oldprint(Tserial.pack(e, true, true))
    end
    
    e.loadItemsFromManifest()
    
    e.vp = Vector(0,0)
    e.vpLerp = 0
    e.vpBounds = love.window.getDimensions()
    
    --Has to be set after the vector library is loaded or bad you'll have a bad day
    
    function e.drawque()
        if not e.doDraw then return end
        for k,v in pairs(e.draw.drawque) do
            if type(v) ~= "function" and e.drawqueIndexBlacklist[k] == nil then
                
                print("Attempted to draw a non function object via drawquee")
                print(k..[["]]..type(v)..[["]])
                print("Item added to the Index Blacklist.")
                e.drawqueIndexBlacklist[k] = true
            else
                if e.drawqueIndexBlacklist[k] == nil then
                    
                    v(dt)
                end
            end
        end
    end
    --Simple draw que function, allows for dynamically adding items to a draw que
    e.hook:add("draw", "e_drawque", e.drawque)
    e.hook:add("update", "e_timer", function() e.timer:run() end)
    e.hook:add("update", "e_noGameVPMovement", function() 
        e.vp.x = math.floor(math.cos(e.vpLerp)*1000)
        e.vp.y = math.floor(math.sin(e.vpLerp)*1000)
        e.vpLerp = e.vpLerp + (3.14*(e.dt/10))
    end)
    e.hook:add("update", "e_introFade", function() 
        
        if e.introFade > 0 then
            e.introFade = e.introFade - (255*(e.dt/10))
        else
            e.hook:remove("update", "e_introFade")
        end
        
    end)
    e.draw = {drawque = setmetatable({}, {__call = e.drawque})}
    
    e.drawqueIndexBlacklist = {}
    
    e.draw.consoleCanvas = love.graphics.newCanvas(e.vpBounds.x, e.vpBounds.y, "normal", 0)
    e.draw.drawque["e_console"] = function(dt)
        if e.console then
            love.graphics.setCanvas(e.draw.consoleCanvas)
            love.graphics.setBlendMode("alpha")
            love.graphics.clear()
            love.graphics.setBackgroundColor({0,0,0,0})
            local I = 0
            local strn = ""
            for I = 0, 10, 1 do
                
                if e.print[#e.print-(I+e.consoleLine)] == nil then break end
                strn = strn..e.print[#e.print-(I+e.consoleLine)][1].."\n"
                
            end
            
            local yOff = e.font:getHeight(strn)*10
            local context = "Lua: \t"..table.concat(e.consoleText)
            
            love.graphics.setColor({64,64,64,64})
            love.graphics.rectangle("fill", v(0,0), v(99999, yOff+35))
            love.graphics.rectangle("fill", v(0,yOff+40), v(99999, e.font:getHeight(strn)+5 ))
            
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
            
            e.olDraw(e.draw.consoleCanvas)
        end
    end
    --Console drawing
    e.draw.debugCanvas = love.graphics.newCanvas(e.vpBounds.x, e.vpBounds.y, "normal", 0)
    e.draw.drawque["e_background_debug"] = function(dt)
        if not e.debug then return end
        love.graphics.setCanvas(e.draw.debugCanvas)
        love.graphics.clear()
        love.graphics.setColor(200,200,255)
        local xOff, yOff = (e.vp%64):splitxyz()
        local xLim, yLim = (e.vpBounds/64):splitxyz(true)
        local x,y = -1, -1
        local drawMe = e.asset:get("image", "noTex")
        for x = -1, math.floor(xLim+0.5), 1 do
            local rX, rY = (x*64)+xOff, (y*64)+yOff
            for y = -1, math.floor(yLim+0.5), 1 do
                rY = (y*64)+yOff
                e.olDraw(drawMe.image, rX, rY)
            end
        end
        love.graphics.setColor({64,64,64,128})
        love.graphics.rectangle("fill", v(0, e.vpBounds.y-e.font:getHeight(strn)-10), v(e.vpBounds.x, e.font:getHeight(strn)+10))
        
        love.graphics.setColor({255,255,255,128})
        e.olLine(
            {
                0, e.vpBounds.y-e.font:getHeight(strn)-6, 
                e.vpBounds.x, e.vpBounds.y-e.font:getHeight(strn)-6
            }
        )
        
        local context = e.vp:toString().."\t|\t"..love.mouse.getPosition():toString()
        love.graphics.setColor({64,64,64})
        love.graphics.print(context, v(10,e.vpBounds.y-e.font:getHeight(strn)-2), 0, v(1,1))
        love.graphics.setColor({255,255,200})
        love.graphics.print(context, v(11,e.vpBounds.y-e.font:getHeight(strn)-2), 0, v(1,1))
        
        
        local context = "LOVE version: "..love._version.."\t|\t Syngyn version: "..e._version.."\t|\tFPS: "..love.timer.getFPS().." ("..math.floor(1/love.timer.getAverageDelta())..")"
        love.graphics.setColor({64,64,64})
        love.graphics.print(context, v(e.vpBounds.x-e.font:getWidth(context)-5, e.vpBounds.y-e.font:getHeight(strn)-2), 0, v(1,1))
        love.graphics.setColor({255,255,200})
        love.graphics.print(context, v(e.vpBounds.x-e.font:getWidth(context)-4, e.vpBounds.y-e.font:getHeight(strn)-2), 0, v(1,1))
        love.graphics.setColor({0,0,0,e.introFade})
        love.graphics.rectangle("fill", v(), e.vpBounds)
        love.graphics.setColor({255,255,255,255-e.introFade})
        e.olDraw(e.asset:get("image", "engine_splash").image, e.asset:get("image", "engine_splash").tiles.engine_default, (e.vpBounds.x/2)-512, (e.vpBounds.y/2)-134)
        
        if e.noGameFlash then
            e.olDraw(e.asset:get("image", "engine_splash").image, e.asset:get("image", "engine_splash").tiles.engine_noGame, (e.vpBounds.x/2)-512, (e.vpBounds.y/2)+44)
        end
        
        love.graphics.setCanvas()
        
        love.graphics.setColor({255,255,255,255})
        e.olDraw(e.draw.debugCanvas)
    end
    
    --love.graphics.setBackgroundColor(180,215,245)
    e.timer:new("e_noGameFlash", 1, true, false, function() e.noGameFlash = not e.noGameFlash end)
end

function love.resize(x,y)
    e.vpBounds.x = x
    e.vpBounds.y = y
    e.draw.debugCanvas = love.graphics.newCanvas(e.vpBounds.x, e.vpBounds.y, "normal", 0)
    e.draw.consoleCanvas = love.graphics.newCanvas(e.vpBounds.x, e.vpBounds.y, "normal", 0)
end

function love.draw()
    e.hook:run("draw")
end

function love.update(dt)
    e.dt = dt
    e.hook:run("update", dt)
    
    if e.console then return false end
    if love.keyboard.isDown("s") then e.vp.y = e.vp.y-math.floor(e.mspeed*dt) end
    if love.keyboard.isDown("d") then e.vp.x = e.vp.x-math.floor(e.mspeed*dt) end
    if love.keyboard.isDown("w") then e.vp.y = e.vp.y+math.floor(e.mspeed*dt) end
    if love.keyboard.isDown("a") then e.vp.x = e.vp.x+math.floor(e.mspeed*dt) end
end

function love.focus(bool)
end

function love.textinput(t)
    if e.consoleTyping and t ~= "`" then
        e.consoleText[#e.consoleText+1] = t
    end
end

function love.keypressed( key, unicode )
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

function love.visible(visible)
    e.doDraw = visible
end

function love.keyreleased( key, unicode )
	
end

function love.mousepressed( x, y, button )
    if button == "wd" then
        if (e.consoleLine + 1) >  (#e.print - 10) then return false end
        e.consoleLine = e.consoleLine + 1
    end
    if button == "wu" then
        if e.consoleLine - 1 < 0 then return false end
        e.consoleLine = e.consoleLine - 1
    end
end

function love.mousereleased( x, y, button )
end

function love.quit()
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