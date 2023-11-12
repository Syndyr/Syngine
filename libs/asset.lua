local asset = { 
    __title = "Asset library",
    __description = [[Provides an asset dictionary, handles the loading, catagorisation and delivery of assets]],
    __author = "Connor Day",
    __version = 1,
    assets = {
        image = {},
        isoTileSet = {},
        audio = {}
    } 
}

function asset:load(folder)

    local base = {}
    local asset = setmetatable(require("assets/"..folder), e.class.__superClass)

    if asset.type == "image" then

        base = e.class:getBase("image", "engine")
        asset = asset+base
        asset.image = love.graphics.newImage("assets/"..folder.."/"..asset.filename..".png")
        
        self.assets.image[asset.name] = asset
        
    elseif asset.type == "isoTileSet" then
        
        local tileSet = require("assets/"..folder.."/"..asset.tileDictionary)
        asset.image = love.graphics.newImage("assets/"..folder.."/images/"..asset.filename..".png")
        local tiles = {}
        local imageSize = Vector(asset.image:getDimensions())

        local function parseVertsIntoMesh(verts, imageDimensions)

            local mesh = {}
            local box = {
                {0,0},
                {128,0},
                {128,128},
                {0,128}
            }

            for k,d in pairs(verts) do
                if k ~= "offset" then

                    local point = box[k]
                    local vec = v(d[1], d[2]) / imageDimensions
                    mesh[#mesh+1] = {point[1], point[2], vec.x, vec.y}

                end
            end

            return love.graphics.newMesh(mesh, "fan", "static")

        end

        for k,v in pairs(tileSet) do
            
            tiles[k] = {}

            for n,b in pairs(v) do
                
                tiles[k][b.sum] = {}

                for g,d in pairs(b) do

                    if g ~= "sum" then

                        local set = tiles[k][b.sum]
                        local tile = e.class:getBase("isoTile", "engine")
                        tile.mesh = parseVertsIntoMesh(d.verts, imageSize)

                        table.insert( set, tile )

                    end
                end
            end
        end
        
        local dictionary = e.class:getBase("isoTileDictionary", "engine")
        dictionary.tiles = tiles
        asset.tileDictionary = dictionary

        self.assets.isoTileSet[asset.name] = asset

    elseif asset.type == "audio" then
        base = e.class:getBase("engine", "audio")
    elseif asset.type == "save" then
        base = e.class:getBase("engine", "save")
    end
end

function asset:get(type, name)
    if type == "image" then
        if self.assets[type][name] ~= nil then
            
            return self.assets[type][name]

        else

            return self:get("image", "noTex")

        end
    else
        if self.assets[type][name] ~= nil then

            return self.assets[type][name]

        end 
    end
end

return asset