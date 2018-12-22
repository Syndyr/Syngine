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
    }
    e.timer.timers[name] = timerOverrides + e.class.getBase("timer", "engine")
    e.timer.timers[name].f = funca
    print("Making a timer..")
end

function e.timer:run()
    local timeNow = love.timer.getTime()
    for k,v in pairs(e.timer.timers) do
        if v.active == true then
            local timeDif = v.timeDue - timeNow
            if timeDif <= 0.001 then
                e.timer.timers[v.name]:fire()
                print("Timer hit with "..e.math.round(timeDif*1000, 2).."ms discrepency")
            end
        end
    end
end
e.timer:new("test", (math.random()*2), true, false, function() print("Hoopla") end)
print("libs.timer done.")