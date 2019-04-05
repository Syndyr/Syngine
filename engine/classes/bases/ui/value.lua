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
    local strin = selfa.data.value()
    if selfa.centered then
        xoff = (selfa.size.x/2) - (e.fonts.arial18:getWidth(strin)/2)
    end
    local col = {255,255,200}
    if type(strin) == "table" then
        col = {255,255,255}
    end
    love.graphics.setColor({64,64,64})
    love.graphics.print(strin, selfa.pos+v(xoff-2, (selfa.size.y/2)-(e.fonts.arial18:getHeight()/2)-0.5))
    love.graphics.setColor(col)
    love.graphics.print(strin, selfa.pos+v(xoff, (selfa.size.y/2)-(e.fonts.arial18:getHeight()/2)))
end