local uiElement = {}

function uiElement.draw(dt, selfa, buttonThink, k, self)
    
    if selfa.data.doDrawn ~= nil then
        if not selfa.data.doDrawn() then
            return false
        end
    end
    if selfa.data.value == nil then selfa.data.value = function() return "No value" end end
    
    love.graphics.setFont(e.fonts.arial18)
    love.graphics.setColor(selfa.colors.secondary)
    love.graphics.rectangle("fill", selfa.pos, selfa.size)
    love.graphics.setColor(selfa.colors.primary)
    love.graphics.rectangle("line", selfa.pos+v(2,2), selfa.size-v(4,4))
    love.graphics.setColor(selfa.colors.terciary)
    
    local xoff = (e.fonts.arial18:getHeight()/2)
    local strin, b = selfa.data.value()
    local col = {255,255,200}
    if type(strin) == "table" then
        col = {255,255,255}
    end
    love.graphics.setColor({64,64,64})
    love.graphics.print(strin.."  "..b, selfa.pos+(v(xoff,8)-5.5))
    love.graphics.setColor(col)
    love.graphics.print(strin.."  "..b, selfa.pos+(v(xoff,8)-5))
    
    love.graphics.setLineWidth(3)
    local x = selfa.pos.x+(e.fonts.arial18:getWidth(selfa.data.limits[1]))+10
    local z = (selfa.size.x-x)-5-(e.fonts.arial18:getWidth(selfa.data.limits[2]))
    local zx = z-x
    local slidepos = x+(zx/selfa.data.limits[2])*b
    
    e.olLine({
        
            x, selfa.pos.y+selfa.size.y-(xoff*2),
            z, selfa.pos.y+selfa.size.y-(xoff*2)
        
        })
    e.olLine({
        
            slidepos, selfa.pos.y+selfa.size.y-(xoff*2)-10,
            slidepos, selfa.pos.y+selfa.size.y-(xoff*2)+10
        
        })
    love.graphics.setLineWidth(1)
    
    love.graphics.print(selfa.data.limits[1], v(5, selfa.pos.y+selfa.size.y-(xoff*3)))
    
    love.graphics.print(selfa.data.limits[2], v(5+z, selfa.pos.y+selfa.size.y-(xoff*3)))
    
end

return uiElement