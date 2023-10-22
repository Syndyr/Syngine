local drawQue = {
    __title = "Draw queue library",
    __description = [[Provides a way of dynamically pushing and pulling drawables]],
    __author = "Connor Day",
    __version = 1,
    que = {
        ui = {},
        other = {}
    },
    
}

function drawQue:addNew(name, catagory, priority, drawFunc, doDraw, pos, size, upX, upY, otherData)
    assert( type(name) == "string" and 
            type(catagory) == "string" and
            type(priority) == "number" and
            type(drawFunc) == "function",
            "Type missmatch.")
    assert(self.que[catagory])
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
    local formatted =  {name = name, catagory = catagory, draw = drawFunc, doDraw = doDraw, pos = pos, size = size, canvas = love.graphics.newCanvas(size.x, size.y), upX = upX, upY = upY}
    formatted = formatted + e.class:getBase("drawable", "engine")
    formatted.otherData = otherData
    table.insert(self.que[catagory], priority, formatted)
    return {self.que[catagory][priority].canvas, self.que[catagory][priority]}
end

function drawQue:draw(dt)
    love.graphics.setCanvas()
    local lastCanvasUsed = love.graphics.getCanvas()
    for k,v in pairs(self.que.other) do
        if v.doDraw then
            love.graphics.setCanvas(v.canvas)
            love.graphics.clear(1,1,1,0)
            v.draw(dt,v)
            love.graphics.setCanvas(lastCanvasUsed)
            if v.catagory ~= "other" then
                break
            end
            e.olDraw(v.canvas, v.pos.x, v.pos.y)
        end
    end
    e.hook:run("e_drawCallAux", dt)
    for k,v in pairs(self.que.ui) do
        if v.doDraw then
            love.graphics.setCanvas(v.canvas)
            love.graphics.clear(1,1,1,0)
            v.draw(dt,v)
            love.graphics.setCanvas(lastCanvasUsed)
            e.olDraw(v.canvas, v.pos.x, v.pos.y)
        end
    end
end

function drawQue.updateCanvasSizes(w)
    local function clk(t,w)
        for k,v in pairs(t) do
            if v.upX then v.size.x = w.x end
            if v.upY then v.size.y = w.y end
            v.canvas = love.graphics.newCanvas(v.size.x, v.size.y)
        end
    end
    clk(drawQue.que.other, w)
    clk(drawQue.que.ui, w)
end

function drawQue:init()
    e.hook:add("draw", "e_drawque", function(dt) self:draw(dt) end)
    e.hook:add("resize", "e_updateCanvasSizes", self.updateCanvasSizes)
end
function drawQue:get(domain, name)
    for k,v in pairs(self.que[domain]) do
        if v.name == name then
            return v, k
        end
    end
end
function drawQue:activate(domaine, name)
    self:get(domain, name).doDraw = true
end

function drawQue:disable(domaine, name)
    self:get(domain, name).doDraw = false
end

function drawQue:toggle(domaine, name)
    self:get(domain, name).doDraw = not self:get(domain, name).doDraw
end

return drawQue