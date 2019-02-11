local UI = {}


UI.base = "e_base"
UI.type = "value"
UI.pos = v()
UI.size = v(120,30)
UI.colors = {
    
    primary = {255,255,255,128},
    secondary = {64,64,64,28},
    terciary = {64,64,64},
    misc = {255,255,200}
    
}
UI.frame = "No frame?"
UI.data = {}

function UI:init()
    local funcArray = {
        
        value = {},
        check = {},
        drop = {},
        input = {},
        dialdisplay = {}
    }
    function funcArray.value.draw(dt, selfa, buttonThink, k)
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
    print("\t\tType "..self.type)
    self.draw = funcArray[string.lower(self.type)].draw
end
return UI