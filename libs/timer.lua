print("Setting S table.")

e.timer = {
    timers = {
        
    },
    timeFunction = love.timer.getTime
}

function e.timer:new(name, delay, startActive, selfDestruct, funca)
    local timerNow = e.timer.timeFunction()
    local timerOverrides = { 
        name = name, 
        timeMade =  timerNow,
        timeDue = timerNow+delay,
        delay = delay,
        active = startActive,
        selfDestruct = selfDestruct,
        f = funca
    }
    e.timer.timers[name] = timerOverrides + e.class.getBase("timer", "engine")
end

function e.timer:run()
    local timeNow = e.timer.timeFunction()
    for k,v in pairs(e.timer.timers) do
        if v.active == true then
            local timeDif = v.timeDue - timeNow
            if timeDif <= 0.001 then
                e.timer.timers[v.name]:fire()
            end
        end
    end
end

print("libs.timer done.")