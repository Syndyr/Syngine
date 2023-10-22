print("Setting S table.")

local timer = {
    __title = "Timer library",
    __description = [[Provides a short framework for the creation of timed events.]],
    __author = "Connor Day",
    __version = 1,
    timers = {
        
    },
    timeFunction = love.timer.getTime
}

function timer:new(name, delay, startActive, selfDestruct, funca)
    local timerNow = self.timeFunction()
    local timerOverrides = { 
        name = name, 
        timeMade =  timerNow,
        timeDue = timerNow+delay,
        delay = delay,
        active = startActive,
        selfDestruct = selfDestruct,
        f = funca
    }
    self.timers[name] = timerOverrides + e.class:getBase("timer", "engine")
end

function timer:run()
    local timeNow = self.timeFunction()
    for k,v in pairs(self.timers) do
        if v.active == true then
            local timeDif = v.timeDue - timeNow
            if timeDif <= 0.001 then
                self.timers[v.name]:fire()
            end
        end
    end
end

print("libs.timer done.")

return timer