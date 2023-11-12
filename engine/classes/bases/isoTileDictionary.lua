local t = {}

t.cid = "iso_tile_dictionary"
t.tiles = {}

function t:getTile(type, sum, subtype)
    
    subtype = subtype == nil and 1 or subtype

    return self.tiles[type][sum][subtype]

end

return t