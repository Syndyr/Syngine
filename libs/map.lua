local t = {
    __title = "Map library",
    __description = [[Originally meant for generating square tile worlds, currently abandoned while isometric worlds are worked on]],
    __author = "Connor Day",
    __version = 1,
    h = { --Header, where map details will go
        --seed = string.toSeed("Cake is a lie"),
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

return t