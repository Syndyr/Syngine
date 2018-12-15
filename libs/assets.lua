e.asset = { assets = {} }

function e.asset:load(folder)
    --e.assets[folder] = require("assets/"..folder)
    local base = {}
    local asset = setmetatable(require("assets/"..folder), e.class.__superClass)
    
    
    
    if asset.type == "image" then
        base = e.class.getBase("engine", "image")
        ass = base+ass
        asset.image = love.graphics.newImage("assets/"..folder.."/"..ass.filename..".png")
    elseif asset.type == "audio" then
        base = e.class.getBase("engine", "audio")
    elseif asset.type == "map" then
        base = e.class.getBase("engine", "map")
    elseif asset.type == "save" then
        base = e.class.getBase("engine", "save")
    end
    self.assets[ass.name] = ass
end


--e.asset:load("tiles/forestFloor")
--e.asset:load("tiles/grass")
--e.asset:load("tiles/rock")
--e.asset:load("tiles/water")
--print(Tserial.pack(e.class, true, true))
--print(Tserial.pack(e.asset.assets, true, true))
