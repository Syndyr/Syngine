function love.load()
    require "errorOverride"
    --Override the default Love2D error handler

    e = {
        print = {}, 
        _version = "0.1.1-11.4",
        console = false, 
        consoleTyping = false, 
        consoleText = {}, 
        consoleLine = 0, 
        debug = true,
        dt = 0,
        fonts = {},
        doDraw = true,
        mspeed = 500,
        introFade = 255,
        noGameFlash = false,
        manifest = require "engine.manifest",
        theta = 1,
        thetaInc = 0.05,
        test = {
            flash = false,
            bottomBar = true,
            radiusTest = false
        }
    }
    e.fonts.arial18 = love.graphics.newFont("assets/fonts/arial.ttf", 18)
    --This is the engine table, all functions should go here.
    --Also functions as a lookup table for the game table
    --Allowing for me to be lazy.
        
    e.oldprint = print
    --Transport print to a different function as we want to hook into it
    
    function print(s)
        --We're making our own print function so it hooks into the console
        
        if s == nil then s = "nil" end
        if type(s) ~= "string" then s = tostring(s) end
        
        if s:find("[^\r\n]+") ~= nil then
            
            for k in s:gmatch("[^\r\n]+") do    
                --e.oldprint("\tTest\t"..k)
                local strn = '['..os.date("%H:%M:%S")..' '..lfs..'] : '..k
                e.oldprint(strn)
                --Do a classic print

                e.print[#e.print+1] = strn
            end
            
            return false
        end
        
        --Some simple input sanitisation 
        local strn = '['..os.date("%H:%M:%S")..' '..lfs..'] : '..s
        e.oldprint(strn)
        --Do a classic print
        
        e.print[#e.print+1] = strn
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
    
    e.setColorNormalised = love.graphics.setColor
    function love.graphics.setColor(r,g,b,a)
        local arg = {r or 255,g or 255,b or 255,a or 255}
        if(type(arg[1]) == "string") then return end
        local r,g,b,a = 0,0,0,0
        if type(arg[1]) == "table" then
            --r,g,b,a = math.min(arg[1][1]/255, 1) or 0, math.min(arg[1][2]/255, 1) or 0, math.min(arg[1][3]/255, 1) or 0, math.min(arg[1][4]/255, 1) or 0
            r = math.min(arg[1][1]/255, 1) or 0
            g = math.min(arg[1][2]/255, 1) or 0
            b = math.min(arg[1][3]/255, 1) or 0
            a = math.min((arg[1][4] or 255)/255, 1) or 0
        else
            r,g,b,a = math.min(arg[1]/255, 1) or 0, math.min(arg[2]/255, 1) or 0, math.min(arg[3]/255, 1) or 0, math.min(arg[4]/255, 1) or 0
        end
        
        e.setColorNormalised(r,g,b,a)
        
    end
    
    g = setmetatable({
    }, {__index = e})
    --This is the game table, any game specific data goes here.
    --Only data, no functions.
    
    function e.loadItemsFromManifest()
        local startTime = love.timer.getTime()*1000
        for k,v in pairs(e.manifest.libraries.thirdParty) do

                local st = l.timer.getTime()

                print("Importing library : libs.thirdParty."..v.."....")

                lfs = "libs."..v

                require("libs.thirdParty."..v)

                lfs = "love.main"

                print("Done ("..((l.timer.getTime()-st)*1000).."ms)\n----------\n")
            
        end
        for k,v in pairs(e.manifest.libraries) do
            
            if k ~= "thirdParty" then
                for n,b in pairs(v) do

                    local st = l.timer.getTime()

                    print("Importing library : libs."..b.."....")

                    lfs = "libs."..b
                    
                    local importedLibrary = require("libs."..b)
                
                   
                    
                    e[b] = importedLibrary

                    lfs = "love.main"
                    print( "---------------------\nTitle: \t\t"..importedLibrary.__title.."\nDescription: \t"..importedLibrary.__description.."\nAuthor: \t\t"..importedLibrary.__author.."\nVersion: \t"..importedLibrary.__version.."\n---------------------")
                    print("Done ("..((l.timer.getTime()-st)*1000).."ms)\n----------\n")
                end
            end
        end
        
        print("Loading bases..\n----------\n")
        for k,v in pairs(e.manifest.bases) do
            print("Importing base: "..v[1].." from domain: "..v[2])
            e.class:getBase(v[1], v[2])
        end
        print("\n----------\nBases loaded.\nLoading assets..\n----------\n")
        for k,v in pairs(e.manifest.assets) do
            print("Getting asset: "..v)
            e.asset:load(v)
        end
        print("")
        print("----------")
        print("")
        print("\n----------\nAssets loaded.\nLoading drawables..\n----------\n")
        for k,v in pairs(e.manifest.drawables) do
            print("Getting drawable: "..v)
            require("assets.drawables."..v)
        end
        print("Fully loaded in "..(love.timer.getTime()*1000)-startTime.."ms")
    end
    e.loadItemsFromManifest()
    e.vp = Vector(0,0)
    e.vpLerp = 0
    e.vpBounds = love.window.getDimensions()
    
    --Has to be set after the vector library is loaded or bad you'll have a bad day
    e.hook:add("e_drawCallAux", "codeDoodle", function()
        local vp = e.vp
        local i, pi, theta, inc, rad = 0, math.pi, e.theta, math.pi/32, love.graphics.getHeight()/2
        local cos, sin = math.cos, math.sin
        local points = {}
            
        for i = 0, pi*2, inc do
            points[#points+1] = (cos(i*theta)*rad)+vp.x
            points[#points+1] = (sin(i*theta)*rad)+vp.y
        end
        
        love.graphics.setColor(122,122,255,255)
        --e.olLine(points)
    end)
    
    e.hook:add("e_drawCallAux", "bearingTest", function()
        if not e.test.radiusTest then return false end
        local screenCenter = e.vpBounds/2
        local mPos = love.mouse.getPosition()
        local pi = math.pi
        
        local zero = v(200,200)+e.vp
        local bearing, mDist = zero:bearing2D(mPos)
        local a = v(0,100)+zero
        local b = v(math.sin(pi*0.125)*mDist, math.cos(pi*0.125)*mDist)+zero
        local c = v(math.sin(bearing)*100, math.cos(bearing)*100)+zero
            
        
            
        --[[
        local ca = v(math.sin(bearing-(pi*0.5))*25, math.cos(bearing-(pi*0.5))*25)+zero
        local bearingcaz = ca:bearing2D(zero)
            
        local cb = v(math.sin(bearingcaz)*25, math.cos(bearingcaz)*25)+zero
        ]]--
            
        local ca, cb = zero:tangent2D(mPos, 12.5)
        
        e.setColorNormalised(1,1,1,1)
        
            
        if bearing >= 0 and bearing <= pi*0.125 then
            love.graphics.setColor(0,255,0,255)
        else
            love.graphics.setColor(255,0,0,255)
        end
        e.olLine({zero.x, zero.y, a.x, zero.y + mDist})
            
        e.olLine({zero.x, zero.y, b.x, b.y})
            
        e.graphics.arch("fill", true, v(200,200)+e.vp, mDist-50, mDist-60, 0, pi*0.125, 16, false)
        if bearing <= 0 then bearing = (bearing)+pi*2 end
        e.graphics.arch("line", true, v(200,200)+e.vp, mDist, mDist-10, 0, bearing, "dynamic", false)
           
        love.graphics.setColor(255,0,255,255)
        e.olLine({zero.x, zero.y, c.x, c.y})
        e.olLine({ca.x, ca.y, cb.x, cb.y})
            
        love.graphics.print(string.format("Sin: %+.4f\nCos: %+.4f\nTan: %+.4f\nBearing: %+.4f", math.sin(bearing), math.cos(bearing), math.atan(math.sin(bearing)/math.cos(bearing)), bearing), v(20,200)+e.vp)
            --string.format("Sin: %+.4f\nCos: %+.4f", math.sin(bearing), math.cos(bearing))
        love.graphics.setColor(255,0,255,255)
    end)
    
    e.hook:add("e_drawCallAux", "fade", function()
        love.graphics.setColor({0,0,0,e.introFade})
        love.graphics.rectangle("fill", v(), e.vpBounds)
    end)
    
    e.hook:add("update", "e_timer", function() e.timer:run() end)
    e.hook:add("update", "e_noGameVPMovement", function() 
        --[[
        e.vp.x = (math.sin(e.vpLerp)*100) - (e.vpBounds.x/2)
        e.vp.y = (math.cos(e.vpLerp)*100) - (e.vpBounds.y/2)
        e.vpLerp = e.vpLerp + 1*e.dt
        ]]--
    end)
    e.timer:new("e_fadeStart", 0.2, true, true, function()
        e.hook:add("update", "e_introFade", function() 

            if e.introFade >= 0 then
                e.introFade = e.introFade - (255*(e.dt))
            else
                e.hook:remove("update", "e_introFade")
            end

        end)
    end)
    e.drawQue:init()
    e.timer:new("e_noGameFlash", 1, true, false, function() e.noGameFlash = not e.noGameFlash end)
    local i = 1
    e.test.ents = {}
    --[[
    for i = 1, 20, 1 do
        e.test.ents[i] = {} + e.table.copy(e.class.getBase("testPlayer", "engine"))
        e.test.ents[i].eid = i
        e.test.ents[i].pos = v(math.random(0, e.vpBounds.x), math.random(0, e.vpBounds.y))
        e.test.ents[i]:init()
        print(i)
        
    end
    
    e.hook:add("update", "testPlayerThink"..i, function() 
        for k,v in pairs(e.test.ents) do
            v:think()
        end
    end)
    ]]--

    e.test.isoTest = e.class:getBase("isoTileMap", "engine")

    e.test.isoTest.tileDictionary = e.asset:get("isoTileSet", "grassAndWaterSheet")

    e.test.isoTest:makeNewTileMap(nil, v(64,64))

    e.hook:add("e_drawCallAux", "testIsoDraw"..i, function() 
        e.test.isoTest:draw(dt)
    end)
end

function love.resize(x,y)
    e.vpBounds.x = x
    e.vpBounds.y = y
    e.hook:run("resize", e.vpBounds)
end
local lineOnce = false
function love.draw()
    if not lineOnce then
        love.graphics.setLineStyle("smooth")
        love.graphics.setLineJoin("none")
        lineOnce = true

        
    end
    
    love.graphics.setFont(e.fonts.arial18)
    
    e.hook:run("draw")
    
    
    --[[
    points = {
        v(20, 10),
        love.mouse.getPosition(),
        v(60, 80),
    }

    vecs = {
        points[1]:getVector(points[2]),
        points[1]:getVector(points[3])
    }
    print(Tserial.pack(vecs,"",true))
    dotProduct = vecs[1]:dotProduct(vecs[2])
    print(dotProduct)
        
    angleBetweenVectors = vecs[1]:angleBetween(vecs[2])
    print(angleBetweenVectors)
        
    projectedDot = vecs[1]:project(vecs[2])
    print(projectedDot)
    
    love.graphics.setColor(128,128,255)
    e.olLine((points[1].x+vecs[2].x*projectedDot)*1.1, (points[1].y+vecs[2].y*projectedDot)*1.1, points[1].x, points[1].y )
    
    love.graphics.setColor(255,0,0)
    e.olLine(points[1].x, points[1].y, points[1].x+vecs[1].x, points[1].y+vecs[1].y )
    
    love.graphics.setColor(0,255,0)
    e.olLine(points[1].x, points[1].y, points[1].x+vecs[2].x, points[1].y+vecs[2].y )
    
    love.graphics.setColor(0,0,255)
    e.olLine(points[1].x+vecs[2].x*projectedDot, points[1].y+vecs[2].y*projectedDot, points[1].x+vecs[1].x, points[1].y+vecs[1].y )
    ]]--
    
    
end

function love.update(dt)
    e.dt = dt
    e.hook:run("update", dt)
    
    if e.console then return false end
    
    if love.keyboard.isDown("s") then e.vp.y = e.vp.y-math.floor(e.mspeed*dt) end
    if love.keyboard.isDown("d") then e.vp.x = e.vp.x-math.floor(e.mspeed*dt) end
    if love.keyboard.isDown("w") then e.vp.y = e.vp.y+math.floor(e.mspeed*dt) end
    if love.keyboard.isDown("a") then e.vp.x = e.vp.x+math.floor(e.mspeed*dt) end
    --print(love.timer.getTime( )%0.1 <= dt)
    if love.timer.getTime( )%0.05 <= dt then e.theta = e.theta + e.thetaInc end
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
    if key == "up" then
        e.theta = e.theta + 0.5
    end
    if key == "down" then
        e.theta = e.theta - 0.5
    end
end

function love.visible(visible)
    e.doDraw = visible
end

function love.keyreleased( key, unicode )
end

function love.mousepressed( x, y, button )
end

function love.wheelmoved( x, y )
    if y == -1 then
        if (e.consoleLine + 1) >  (#e.print - 10) then return false end
        e.consoleLine = e.consoleLine + 1
    end
    if y == 1 then
        if e.consoleLine - 1 < 0 then return false end
        e.consoleLine = e.consoleLine - 1
    end
end

function love.mousereleased( x, y, button )
    e.ui.buttonCatch = false
end

function love.quit()
    print(type(e.print[1]))
    local str = table.concat(e.print, "\n\r")
    love.filesystem.append("log_"..os.date("%d%m%y%H%M%S")..math.random(0,99999)..".txt", "\n_______________________________________\n\n"..os.date("%d_%m_%y_%H%M").."\n\n_______________________________________\n\n"..str, str:len())
end