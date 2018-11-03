print("Defining g.generate function.")
function string.toSeed(s)
    local trans = {
        ["0"] = 100,
        ["1"] = 1,
        ["2"] = 2,
        ["3"] = 3,
        ["4"] = 4,
        ["5"] = 5,
        ["6"] = 6,
        ["7"] = 7,
        ["8"] = 8,
        ["9"] = 10,
        ["a"] = 11,
        ["b"] = 12,
        ["c"] = 13,
        ["d"] = 14,
        ["e"] = 15,
        ["f"] = 16,
        ["g"] = 17,
        ["h"] = 18,
        ["i"] = 19,
        ["j"] = 20,
        ["k"] = 21,
        ["l"] = 22,
        ["m"] = 23,
        ["n"] = 24,
        ["o"] = 25,
        ["p"] = 26,
        ["q"] = 27,
        ["r"] = 28,
        ["s"] = 29,
        ["t"] = 30,
        ["u"] = 31,
        ["v"] = 32,
        ["w"] = 33,
        ["x"] = 34,
        ["y"] = 35,
        ["z"] = 36,
        [" "] = 36
    }
    s = string.lower(s)
    local i = 1
    local tes = 0
    --print(string.len(s))
    for i = 1, string.len(s) do
        if string.sub(s, i, (string.len(s)-i+1)*-1) ~= nil then
            tes = tes+trans[string.sub(s, i, (string.len(s)-i+1)*-1)]
        end
    end
    
    return tonumber(tes)
end
print("Derp\t:\t"..string.toSeed("Cake is a lie"))

local t = {
    h = { --Header, where map details will go
        seed = string.toSeed("Cake is a lie"),
        name = "Wasteland",
        cl = "wl",
        gdsl = 32,
        gdl = Vector(8,8),
        depth = 4
    },
    d = { --Data, where map data goes
        g = { --Grids, where grid data is stored
            x = { --X coordinate 
                y = { --Y coordinate and where final data is stored
                    t = { --Tiles
                        y = { --Y coordinate
                            x = { --X coordinate and where final data is stored
                            }
                        }
                    }
                }
            }
        }
    }
}

function g.generate(veclimit, gridsize, seed, options)
    --[[
        Grid (Map) generation.
        veclimit = amount of grids in x/y
        grid size = size of a grid, i.e 16 would make a 16x16 grid
    ]]--
    
    local map = {} 
    setmetatable(map, {__index = t})
    if type(options) == "table" then
        if #options > 0 then
            map.h.name = options.name or map.h.name
            map.h.cl = options.cl or map.h.cl
            map.h.depth = options.depth or map.h.depth
        end
    end
    if veclimit == nil then veclimit = t.h.gdl else map.h.gdl = veclimit end
    if gridsize == nil then gridsize = t.h.gdsl else map.h.gdsl = gridsize end
    if seed == nil then seed = t.h.seed else map.h.seed = seed end
    love.math.setRandomSeed(seed)
    local function genGridTiles(lim, offsets)
        local x = 1
        local y = 1
        tiles = {y = {x = {}}}
        for y = 1, gridsize do
            x = 1
            for x = 1, gridsize do
                local tile = {}
                tile.l = math.floor(love.math.noise((offsets.x+x)/2,(offsets.y+y)/2, 1)*map.h.depth)
                
                tiles[y][x] = tiles
            end
        end
    end
    
end

print("Defining g.save.")
function g.save(name)
    --[[
        Grid (Map) save function.
    ]]--
end
print("Defining g.load.")
function g.load(name)
    --[[
        Grid (map) load function.
    ]]--
end
print("libs.map done.")



    --[[
    local y = 1
    for y = 1, 1024, 1 do
        local x = 1
        tempTileArray[y] = {}
        for x = 1, 1024, 1 do
            tempTileArray[y][x] = {
                level = math.floor(4*love.math.noise(seed+x/20,seed+y/20, 0, 1))+1,
                bg = false
                
            }
            
        end
    end
    curTile = v()
    tiles = {
        images = {
            ["water"] = love.graphics.newImage("assets/water.png")
        },
        tiles = {
        }
    }
    tiles.tiles.waterTop = love.graphics.newQuad(v(2048-64,64), v(64,64), tiles.images.water:getDimensions())
    tiles.tiles.waterBottom = love.graphics.newQuad(v(2048-64,0), v(64,64), tiles.images.water:getDimensions())
    tiles.tiles.waterSparkle = love.graphics.newQuad(v(0,0), v(1920,1080), tiles.images.water:getDimensions())
    colindex = {{150,150,255, 0},{64,128,64}, {128,128,128}, {192,192,192}, {255,0,0}}
    --[[
        
            [0 ][5][0 ]
            [17][X][7 ]
            [0 ][11][0]
            
            [O][O][O]
            [O][X][O]
            [O][O][O]
    
    function smoothTiles(sourceTile)
        
        if sourceTile ~= nil then
            
        else
            for k,v in pairs(tempTileArray) do
                for n,b in pairs(v) do
                    tempTileArray[k][n].bg = false
                    local worTile = Vector(n,k)
                    local bg = 0
                    local sum = 0
                    if tempTileArray[k-1] ~= nil then
                        if tempTileArray[k-1][n].level > b.level then
                            sum = sum + 5 
                            bg = tempTileArray[k-1][n].level
                        end
                    else 
                        sum = sum + 5 
                    end
                    if tempTileArray[k][n+1] ~= nil then
                        if tempTileArray[k][n+1].level > b.level then
                            sum = sum + 7
                            bg = tempTileArray[k][n+1].level
                        end
                    else 
                        sum = sum + 7
                    end
                    if tempTileArray[k+1] ~= nil then
                        if tempTileArray[k+1][n].level > b.level then
                            sum = sum + 11
                            bg = tempTileArray[k+1][n].level
                        end
                    else 
                        sum = sum + 11
                    end
                    if tempTileArray[k][n-1] ~= nil then
                        if tempTileArray[k][n-1].level > b.level then
                            sum = sum + 17
                            bg = tempTileArray[k][n-1].level
                        end
                    else 
                        sum = sum + 17
                    end
                    if bg == 0 then bg = 5 end
                    
                    
                    if sum == 40 then 
                        tempTileArray[k][n].level = bg 
                    else
                        if sum > 0 then 
                            bg = {
                                ["bg"] = bg,
                                grad = sum
                            }
                            tempTileArray[k][n].bg = bg 
                        end
                    end
                end
            end
        end
    end
    
    
    
    trims = {image = love.graphics.newImage("assets/Grass_01_Color.png")}
    trims2 = {image = love.graphics.newImage("assets/Grass_01_Color.png")}
    
    trims2[12] = {Vector(0,0), Vector(64,0), Vector(64,64)}
    trims2[18] = {Vector(64,0), Vector(64,64), Vector(0, 64)}
    trims2[22] = {Vector(0,0), Vector(64,0), Vector(0,64)}
    trims2[28] = {Vector(0,0), Vector(64,64), Vector(0, 64)}
    
    
    trims[12] = love.graphics.newMesh({
        {0,0,0,0},
        {64,0,1,0},
        {64,64,1,1},
    }, trims.image, "triangles")
    trims[18] = love.graphics.newMesh({
        {64,0,1,0},
        {64,64,1,1},
        {0,64,0,1},
    }, trims.image, "triangles")
    trims[22] = love.graphics.newMesh({
        {0,0,0,0},
        {64,0,1,0},
        {0,64,0,1},
    }, trims.image, "triangles")
    trims[28] = love.graphics.newMesh({
        {0,0,0,0},
        {64,64,1,1},
        {0,64,0,1},
    }, trims.image, "triangles")
    tileDictionary = {
        love.graphics.newMesh({
            {0,0,0,0},
            {64,0,1,0},
            {64,64,1,1},
            {0,64,0,1},
        }, trims.image, "fan"),
        love.graphics.newMesh({
            {0,0,0,0},
            {64,0,1,0},
            {64,64,1,1},
            {0,64,0,1},
        }, trims.image, "fan")
    }
    wave = 0
    smoothTiles()
    function tempTileTest()
        
        local screenDia = love.window.getDimensions()
        local offset = ((screenDia/2) + g.vp)
        local tlt = -Vector(math.floor((offset.x)/64),math.floor((offset.y)/64))
        local curPos = love.mouse.getPosition()
        curTile.x, curTile.y = math.floor(((curPos.x-offset.x)/64)), math.floor(((curPos.y-offset.y)/64))
        love.graphics.setColor(255,255,255)
        
        local waterTileMaxes = v(math.floor(screenDia.x/64),math.floor(screenDia.y/64))+2
        local waterOffset = v(math.floor(g.vp.x%64), math.floor(g.vp.y%64))
        
        local x = -1
        for x = -1, waterTileMaxes.x, 1 do
            local y = -1
            for y = -1, waterTileMaxes.y, 1 do
                
                love.graphics.draw(tiles.images.water, tiles.tiles.waterBottom, v(x*64,y*64)+waterOffset)
                
            end
        end
        
        love.graphics.draw(tiles.images.water, tiles.tiles.waterSparkle, v(math.floor((math.cos(wave)*50)+x*64),math.floor((math.sin(wave)*50)+y*64)))
        
        local x = -1
        for x = -1, waterTileMaxes.x, 1 do
            local y = -1
            for y = -1, waterTileMaxes.y, 1 do
                
                love.graphics.draw(tiles.images.water, tiles.tiles.waterTop, v(math.floor((math.sin(wave)*50)+x*64),math.floor((math.cos(wave)*50)+y*64))+waterOffset)
                
            end
        end
        
        --for k,v in pairs(tempTileArray) do
        local k = -2+tlt.y
        for k = -2+tlt.y, math.floor(screenDia.y/64)+2+tlt.y, 1 do
            --for n,b in pairs(v) do
            local n = -2+tlt.x
            for n = -2+tlt.x, math.floor(screenDia.x/64)+2+tlt.x, 1 do
                if k > 0 and n > 0 then
                    local worTile = Vector(n,k)
                    local mo = "fill"
                    if tempTileArray[k] ~= nil then
                        if tempTileArray[k][n] ~= nil then
                            local b = tempTileArray[k][n]
                            if not b.bg then

                                if b.level == 2 then
                                    
                                    
                                    love.graphics.setColor({255,255,255}) 
                                    olDraw(tileDictionary[2] ,offset.x+(worTile.x*64),offset.y+(worTile.y*64))
                                else
                                    love.graphics.setColor(colindex[tempTileArray[k][n].level] or {255,255,0})
                                    love.graphics.rectangle(mo, offset+(worTile*64), Vector(64,64))
                                end

                            else
                                if b.level == 2 then
                                    
                                    
                                    love.graphics.setColor({255,255,255}) 
                                    olDraw(tileDictionary[2] ,offset.x+(worTile.x*64),offset.y+(worTile.y*64))
                                else
                                    love.graphics.setColor(colindex[tempTileArray[k][n].level] or {255,255,0})
                                    love.graphics.rectangle(mo, offset+(worTile*64), Vector(64,64))
                                end
                                if trims[b.bg.grad] ~= nil then
                                    if b.level == 1 then
                                        love.graphics.setColor(colindex[tempTileArray[k][n].level] or {255,255,0})
                                        love.graphics.rectangle(mo, offset+(worTile*64), Vector(64,64))
                                        
                                        love.graphics.setColor(255,255,255)
                                        olDraw(trims[b.bg.grad], offset.x+(worTile.x*64), offset.y+(worTile.y*64))
                                    else
                                    
                                        local grad = trims2[b.bg.grad]
                                        local grad2 = {grad[1]+offset+(worTile*64),grad[2]+offset+(worTile*64),grad[3]+offset+(worTile*64)}
                                        local grad3 = {grad2[1].x, grad2[1].y, grad2[2].x, grad2[2].y, grad2[3].x, grad2[3].y}

                                        love.graphics.setColor(colindex[tempTileArray[k][n].bg.bg] or {255,255,0})
                                        love.graphics.polygon("fill", grad3)
                                        --love.graphics.setColor(255,0,0)
                                        --love.graphics.print(b.bg.grad, offset+(worTile*64)+Vector(32,32))

                                    end
                                end
                            end

                            if worTile == curTile then 
                                love.graphics.setColor({255,0,255})
                                love.graphics.rectangle("line", offset+(worTile*64), Vector(64,64))
                            end
                        end
                    end
                end
            end
        end
        love.graphics.setColor(0,0,0)
        love.graphics.rectangle("line", offset+v((math.sin(wave)*50),(math.cos(wave)*50)), v(10,10))
        
        love.graphics.setColor(0,0,0)
        love.graphics.print("CurTile : "..curTile["x"]..", "..curTile["y"].."\nOffset : "..offset["x"]..", "..offset["y"].."\nTlt : "..tlt["x"]..", "..tlt["y"].."\nwoff : "..waterOffset["x"]..", "..waterOffset["y"], v(1,1), 0, v(1,1))
        
    end
    ]]--