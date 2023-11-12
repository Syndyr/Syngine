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

function asset:parseVertsIntoMesh(verts, imageDimensions, image)

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

            e.oldprint(k, d[1], d[1]/imageDimensions.x, d[2], d[2]/imageDimensions.y )
            table.insert(mesh,  {point[1], point[2], vec.x, vec.y})

        end
    end
    local meshTextured = love.graphics.newMesh(mesh, "fan", "static")
    meshTextured:setTexture(image)
    return {mesh = meshTextured, verts = mesh}

end

function asset:load(folder)

    local base = {}
    local workingAsset = setmetatable(require("assets/"..folder), e.class.__superClass)

    if workingAsset.type == "image" then

        base = e.class:getBase("image", "engine")
        workingAsset = workingAsset+base
        workingAsset.image = love.graphics.newImage("assets/"..folder.."/"..workingAsset.filename..".png")
        
        self.assets.image[workingAsset.name] = workingAsset
        
    elseif workingAsset.type == "isoTileSet" then
        
        local tileSet = require("assets/"..folder.."/"..workingAsset.tileDictionary)
        workingAsset.image = love.graphics.newImage("assets/"..folder.."/images/"..workingAsset.filename..".png")
        local tilesTest = {}
        local imageSize = Vector(workingAsset.image:getDimensions())

        for k,v in pairs(tileSet) do
            tilesTest[k] = {}

            

            for n,b in pairs(v) do
                
                tilesTest[k][b.sum] = {}

                for g,d in pairs(b) do

                    if g ~= "sum" then

                        local set = tilesTest[k][b.sum]
                        local tile = e.table.copy(e.class:getBase("isoTile", "engine"))
                        tile.mesh = self:parseVertsIntoMesh(d.verts, imageSize, workingAsset.image)

                        table.insert( tilesTest[k][b.sum], tile )

                    end
                end
            end

            print("#tiles")
            e.oldprint(tilesTest.water == nil)
            e.oldprint(tilesTest.grass == nil)
            print("asdasdasd")

        end
        --[[
        e.oldprint(Tserial.pack(tiles, 
        function(v) 
            local v = type(v) == "string" and v or type(v) 
            return v
        end, true))
        ]]
        local dictionary = e.class:getBase("isoTileDictionary", "engine")
        dictionary.tiles = tilesTest
        workingAsset.tileDictionary = dictionary

        self.assets.isoTileSet[workingAsset.name] = workingAsset

    elseif workingAsset.type == "audio" then
        base = e.class:getBase("engine", "audio")
    elseif workingAsset.type == "save" then
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