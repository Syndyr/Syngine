local c = {}

c.cid = "base_class"
c.name = "Base Class"

c.active = false
c.data = {}
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