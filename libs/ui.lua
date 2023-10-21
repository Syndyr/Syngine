e.ui = {
    frames = {},
    buttonCatch = false,
    typingElement = {},
    themes = {
        theme = "standard",
        standard = {
            
            global = {
                
                primary = {255,255,255,128},
                secondary = {64,64,64,28},
                terciary = {64,64,64},
                misc = {255,255,200}
                
            }
            
        }
        
    },
    debug = false
}
function e.ui:setTheme(theme)
    if self.themes[theme] == nil then return false end
    
    self.themes.theme = theme
    
    return true
end

function e.ui:getTheme()
    return self.themes.theme
end
function e.ui:getThemeColour(...)
    
    local args = {...}
    local scope = args[1]
    local context = args[2]
    local iof = 0
    if #args == 1 then 
        scope = self.themes.theme
        context = "global"
        iof = 2
    end
    local index = args[3-iof]
    return self.themes[scope][context][index]
end
function e.ui:testTheme(...)
    print(table.concat(e.ui:getThemeColour(...), ", "))
end
function e.ui:createFrame(name, priority, doDraw, pos, size, upX, upY)
    assert( type(name) == "string" and
            type(priority) == "number",
            "Type missmatch.")
    if pos then
        assert(getmetatable(pos) ~= v(), "Position type given is incorrect")
    else
        pos = v()
    end
    if size then
        assert(getmetatable(size) ~= v(), "Size type given is incorrect")
    else
        size = e.vpBounds
    end
    if doDraw == nil then doDraw = false end
    if upX == nil then upX = false end
    if upY == nil then upY = false end
    local formatted =  {name = name, catagory = "ui", draw = drawMeta, doDraw = doDraw, pos = pos, size = size, upX = upX, upY = upY}
    formatted = formatted + e.class.getBase("uiFrame", "engine")
    formatted.canvas = e.drawQue:addNew(
        name, 
        "ui", 
        0, 
        formatted.drawMeta, 
        true, 
        formatted.pos, 
        formatted.size, 
        formatted.upX, 
        formatted.upY, 
        {
            name
        }
    )
    e.ui.frames[name] = formatted
    return e.ui.frames[name]
end

function e.ui.getFrame(name)
    return e.ui.frames[name]
end

--[[

local objectData = {
        centered = false, 
        data = {
        }
    }
function objectData.data.value()
    return {{255,0,0}, "red",{0,255,0}, "green",{0,0,255}, "blue"}
end
e.ui.getFrame("test"):add("Value", objectData)

objectData = {
        centered = false, 
        pos = v(0,64),
        size = v(140, 30),
        data = {
            toggleVar = function()
                
                e.ui.debug = not e.ui.debug
                return e.ui.debug
            
            end,
            checkStat = e.ui.debug
        }
    }
function objectData.data.value()
    local col = {255,0,0}
    if e.ui.debug then col = {0,255,0} end
    return {col, "UI DEBUG"}
end

e.ui.getFrame("test"):add("Check", objectData)

function frame:removeFrame()
    frame = nil
end
        item = {
            1 = class [button, text, value, dial]
            2 = name
            3 = pos {x,y} (local to frame)
            4 = size {x,y}
            5 = object data { 
                1 = text 
                2+ object specific data
            }
        }
    ]]--