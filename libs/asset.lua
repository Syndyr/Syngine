local asset = { 
    __title = "Asset library",
    __description = [[Provides an asset dictionary, handles the loading, catagorisation and delivery of assets]],
    __author = "Connor Day",
    __version = 1,
    assets = {
        image = {},
        audio = {}
    } 
}

function asset:load(folder)
    --e.assets[folder] = require("assets/"..folder)
    local base = {}
    local asset = setmetatable(require("assets/"..folder), e.class.__superClass)
    
    if asset.type == "image" then
        base = e.class:getBase("image", "engine")
        asset = asset+base
        asset.image = love.graphics.newImage("assets/"..folder.."/"..asset.filename..".png")
        
        self.assets.image[asset.name] = asset
        
    elseif asset.type == "audio" then
        base = e.class:getBase("engine", "audio")
    elseif asset.type == "map" then
        base = e.class:getBase("engine", "map")
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