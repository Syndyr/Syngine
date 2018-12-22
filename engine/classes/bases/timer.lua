local t = {}

t.name = ""
t.timeMade = 0
t.timeDue = 0
t.delay = 0
t.active = false
t.selfDestruct = true
t.kill = false
function t:activate()
    self.timeDue = love.timer.getTime() + self.delay
    self.active = true
end

function t:fire()
    if t ~= nil then
        local name = self.name
        local te = e.timer.timers[name]
        if te ~= nil then
            if e.timer.timers[te.name].f ~= nil then
                e.timer.timers[te.name].f(self)
            else
                print("No function to fire for this timer?")
            end
            te.active = false
            if te.selfDestruct then
                e.timer.timers[name] = nil
            else
                te:activate()
            end
        end
    end
end

return t