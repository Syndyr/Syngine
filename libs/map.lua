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
