e.drawQue = {
    
    que = {
        ui = {},
        other = {}
    },
    
}
function e.drawQue:addNew(name, catagory, priority, drawFunc, doDraw, pos, size, upX, upY)
    assert( type(name) == "string" and 
            type(catagory) == "string" and
            type(priority) == "number" and
            type(drawFunc) == "function",
            "Type missmatch.")
    assert(self.que[catagory])
    if pos then
        assert(getmetatable(pos) ~= v(), "Position value given is incorrect")
    else
        pos = v()
    end
    if size then
        assert(getmetatable(size) ~= v(), "Size value given is incorrect")
    else
        size = e.vpBounds
    end
    if doDraw == nil then doDraw = false end
    if upX == nil then upX = false end
    if upY == nil then upY = false end
    local formatted =  {name = name, catagory = catagory, draw = drawFunc, doDraw = doDraw, pos = pos, size = size, canvas = love.graphics.newCanvas(size.x, size.y), upX = upX, upY = upY}
    formatter = formatted + e.class.getBase("drawable", "engine")
    table.insert(self.que[catagory], priority, formatted)
end

function e.drawQue.draw(dt)
    local lastCanvasUsed = love.graphics.getCanvas()
    for k,v in pairs(e.drawQue.que.other) do
        if v.doDraw then
            love.graphics.setCanvas(v.canvas)
            v.draw(dt)
            love.graphics.setCanvas(lastCanvasUsed)
            e.olDraw(v.canvas, v.pos.x, v.pos.y)
        end
    end
    e.hook:run("e_drawCallAux", dt)
    for k,v in pairs(e.drawQue.que.ui) do
        if v.doDraw then
            love.graphics.setCanvas(v.canvas)
            v.draw(dt)
            love.graphics.setCanvas(lastCanvasUsed)
            e.olDraw(v.canvas, v.pos.x, v.pos.y)
        end
    end
end
function e.drawQue.updateCanvasSizes(w)
    local function clk(t,w)
        for k,v in pairs(t) do
            if v.upX then v.size.x = w.x end
            if v.upY then v.size.y = w.y end
            v.canvas = love.graphics.newCanvas(v.size.x, v.size.y)
        end
    end
    clk(e.drawQue.que.other, w)
    clk(e.drawQue.que.ui, w)
end
function e.drawQue:init()
    e.hook:add("draw", "e_drawque", e.drawQue.draw)
    e.hook:add("resize", "e_updateCanvasSizes", e.drawQue.updateCanvasSizes)
end