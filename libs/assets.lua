assets = {}

function assets.load(folder)
    assets[folder] = require("assets/"..folder)
end

assets = setmetatable(assets, {
    __newindex = function(self, k, v)
        if v.type == "image" then
            local filepath = "assets/"..k..".png"

            if v.filename ~= nil then filepath = "assets/"..k.."/"..v.filename..".png" end
            v.image = love.graphics.newImage(filepath)
        elseif v.type == "audio" then
            
        elseif v.type == "map" then
                
        elseif v.type == "save" then
                
        end
        rawset(self, k, v)
    end
})
--[[
assets.load("tiles/forestFloor")
assets.load("tiles/grass")
assets.load("tiles/rock")
assets.load("tiles/water")
]]--