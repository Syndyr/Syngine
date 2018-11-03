e.ui = {
    frames = {}
    
}
local frame = {}

function e.ui.createFrame(name, pos, size)
    
end

function e.ui.getFrame(name)
    return e.ui.frames[name]
end

function frame:removeFrame()
    frame = nil
end
function e.ui.makeItem(name, class, text, ...)
    
end
function frame:additem(item)
    --[[
        item = {
            1 = class [button, text, value]
            2 = name
            3 = pos {x,y} (local to frame)
            4 = size {x,y}
            5 = object data { 
                1 = text 
                2+ object specific data
            }
        }
    ]]--
end