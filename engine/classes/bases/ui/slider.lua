local uiElement = {}

function uiElement.draw(dt, selfa, buttonThink, k, self)
    
    if selfa.data.doDrawn ~= nil then
        if not selfa.data.doDrawn() then
            return false
        end
    end
    if selfa.data.value == nil then selfa.data.value = function() return "No value" end end
    local theme = e.ui:getTheme()
    local colours = {
        
        primary = selfa.colours.primary or e.ui:getThemeColour("primary"),
        secondary = selfa.colours.secondary or e.ui:getThemeColour("secondary"),
        terciary = selfa.colours.terciary or e.ui:getThemeColour("terciary"),
        misc = selfa.colours.misc or e.ui:getThemeColour("misc")
        
    }
    
    love.graphics.setFont(e.fonts.arial18)
    love.graphics.setColor(colours.secondary)
    love.graphics.rectangle("fill", selfa.pos, selfa.size)
    
    love.graphics.setColor(colours.primary)
    love.graphics.rectangle("line", selfa.pos+v(2,2), selfa.size-v(4,4))
    love.graphics.setColor(colours.terciary)
    
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
    local mpos = selfa.frame:getMousePos()
    
    
    local x = selfa.pos.x+(e.fonts.arial18:getWidth(selfa.data.limits[1]))+10
    local z = (selfa.size.x-x)-5-(e.fonts.arial18:getWidth(selfa.data.limits[2]))
    local zx = z-x
    
    local scaleMod = x+(zx/selfa.data.limits[2])*b
    
    local slidepos = math.max(math.min(scaleMod, z), x)
    
    e.olLine({
        
            x, selfa.pos.y+selfa.size.y-(xoff*2),
            z, selfa.pos.y+selfa.size.y-(xoff*2)
        
        })
    local ypos = selfa.pos.y+selfa.size.y-(xoff*2)
    local xMod = 0
    if buttonThink then
        if fuzzyeq(mpos.x, slidepos, 3) and fuzzyeq(mpos.y, ypos, 10) or selfa.dragging then 
            love.graphics.setLineWidth(5)
            love.graphics.setColor(40,128,40,255)

            if love.mouse.isDown(e.keys.__leftMouseButton__) then
                xMod = mpos.x - slidepos
                local calcedVar = e.math.maxmin(((slidepos+xMod-x)/zx)*selfa.data.limits[2], selfa.data.limits[2], selfa.data.limits[1])

                selfa.data.setVar(calcedVar)

                selfa.dragging = true
                e.ui.buttonCatch = true
            else
                selfa.dragging = false

            end

        end
    end
    e.olLine({
        
            e.math.maxmin(slidepos+xMod, z, x), ypos-10,
            e.math.maxmin(slidepos+xMod, z, x), ypos+10
        
        })
    love.graphics.setColor(col)
    love.graphics.setLineWidth(1)
    
    love.graphics.print(selfa.data.limits[1], v(5, selfa.pos.y+selfa.size.y-(xoff*3)))
    
    love.graphics.print(selfa.data.limits[2], v(5+z, selfa.pos.y+selfa.size.y-(xoff*3)))
    
end

return uiElement