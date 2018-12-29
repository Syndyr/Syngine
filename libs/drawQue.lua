e.drawQue = {
    
    que = {
        ui = {},
        other = {}
    },
    
}
function e.drawQue:init()
    e.hook:add("draw", "e_drawque", e.drawQue.draw)
end

function e.drawQue:addNew(name, catagory, priority, drawFunc, doDraw, pos, size)
    assert( type(name) == "string" and 
            type(catagory) == "string" and
            type(priority) == "number" and
            type(drawFunc) == "function",
            "Type missmatch.")
    assert(self[que][catagory])
    if pos then
        assert(getmetatable(pos) == v(), "Position value given is incorrect")
    else
        pos = v()
    end
    if size then
        assert(getmetatable(size) == v(), "Position value given is incorrect")
    else
        size = e.vpBounds
    end
    if doDraw == nil then doDraw = false end
    local formatted = e.class.getBase("engine", "drawable") + {name = name, catagory = catagory, draw = draw, doDraw = doDraw, pos = pos, size = size, canvas = love.graphics.newCanvas(size.x, size.y)}
    
    table.insert(self[que][catagory], priority, formatted)
end

function e.drawQue.draw(dt)
    local lastCanvasUsed = love.graphics.getCanvas()
    for k,v ipairs(e.drawQue.que.other) do
        if v.doDraw then
            love.graphics.setCanvas(v.canvas)
            v.draw(dt)
            love.graphics.setCanvas(lastCanvasUsed)
            e.olDraw(v.canvas, v.pos.x, v.pos.y)
        end
    end
    e.hook:run("e_drawCallAux", dt)
    for k,v ipairs(e.drawQue.que.other) do
        if v.doDraw then
            love.graphics.setCanvas(v.canvas)
            v.draw(dt)
            love.graphics.setCanvas(lastCanvasUsed)
            e.olDraw(v.canvas, v.pos.x, v.pos.y)
        end
    end
end