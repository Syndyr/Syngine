e.ui = {
    frames = {},
    debug = true
}

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
    formatted.canvas = e.drawQue:addNew(name, "ui", priority, formatted.drawMeta, formatted.doDraw, formatted.pos, formatted.size, formatted.upX, formatted.upY, {name})
    e.ui.frames[name] = e.class.getBase("uiFrame", "engine") + formatted
end
e.ui:createFrame("test", 1, true, v(200,200), v(250,250), false, false)
function e.ui.getFrame(name)
    return e.ui.frames[name]
end
local objectData = {
        centered = false, 
        data = {
        }
    }
function objectData.data.value()
    return math.floor(love.timer.getTime())
end
e.ui.getFrame("test"):add("Value", objectData)

objectData = {
        centered = false, 
        pos = v(0,32),
        data = {
        }
    }
function objectData.data.value()
    return math.random(0,1000)
end

e.ui.getFrame("test"):add("Value", objectData)
--[[
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