local c = {}

c.cid = "base_class"
c.name = "Base Class"

c.drawable = false
c.active = false

c.pos = v()
c.size = v(1,1)
c.scale = c.size

c.data = {}

function c:draw()
    return false
end
function c:getClassID()
    return self.cid
end
function c:click()
    return true
end
function c:hover()
   return true 
end

return c