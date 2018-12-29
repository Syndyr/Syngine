e.asset = { 
    assets = {
        image = {},
        audio = {}
    } 
}

function e.asset:load(folder)
    --e.assets[folder] = require("assets/"..folder)
    local base = {}
    local asset = setmetatable(require("assets/"..folder), e.class.__superClass)
    
    if asset.type == "image" then
        base = e.class.getBase("image", "engine")
        asset = asset+base
        asset.image = love.graphics.newImage("assets/"..folder.."/"..asset.filename..".png")
        
        e.asset.assets.image[asset.name] = asset
        
    elseif asset.type == "audio" then
        base = e.class.getBase("engine", "audio")
    elseif asset.type == "map" then
        base = e.class.getBase("engine", "map")
    elseif asset.type == "save" then
        base = e.class.getBase("engine", "save")
    end
end

function e.asset:get(type, name)
    if type == "image" then
        if e.asset.assets[type][name] ~= nil then
            return e.asset.assets[type][name]
        else
            return e.asset:get("image", "noTex")
        end
    end
end