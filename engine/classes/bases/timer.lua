local t = {}

t.name = ""
t.timeMade = 0
t.timeDue = 0
t.delay = 0
t.active = false
t.selfDestruct = true
t.kill = false
function t:activate()
    t.timeDue = love.timer.getTime() + t.delay
    t.active = true
end

function t:fire()
    if t ~= nil then
        local name = t.name
        local te = e.timer.timers[name]
        
        if e.timer.timers[te.name].f ~= nil then
            e.timer.timers[te.name].f()
        else
            print("No function to fire for this timer?")
        end
        if te.selfDestruct == true then
            te.kill = true
            e.timer.timers[te.name] = nil
            te = nil
        end
        te.active = false
    end
end

return t