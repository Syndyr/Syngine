assets = {}

function assets.load(folder)
    assets[folder] = require("assets/"..folder)
end

assets = setmetatable(assets, {
    __newindex = function(self, k, v)
        local filepath = "assets/"..k..".png"
            
        if v.filename ~= nil then filepath = "assets/"..k.."/"..v.filename..".png" end
        v.image = love.graphics.newImage(filepath)
            
        rawset(self, k, v)
    end
})
--[[
assets.load("tiles/forestFloor")
assets.load("tiles/grass")
assets.load("tiles/rock")
assets.load("tiles/water")
]]--