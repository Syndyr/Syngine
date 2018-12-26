print("Setting S table.")

e.timer = {
    timers = {
        
    }
}

function e.timer:new(name, delay, startActive, selfDestruct, funca)
    local timerNow = love.timer.getTime()
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
    local timeNow = love.timer.getTime()
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