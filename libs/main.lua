print('Setting M table.')
m = {}
print('Setting m.loadclk to 0.')
m.loadclk = 0
print('Defining m.l function.')
function m.l()
    --[[
        Main load function.
    --]]
    if g == nil then
        if m.loadclk > 5 then 
            print("\n\nMain attempted to be ran too many times before Map library was loaded.")
            return false 
        end
        print("\n\nMain attempted to be ran before Map library was loaded.\nWill retry in 1ms.\n\n")
        s.timerf("m.lreload", function() print("hi") m.l() m.loadclk = m.loadclk + 1 end, 1)
        return false
    end
    print("")
    print("")
    print("----------")
    print("")
    print("")
    print("Successfully loaded libs.main correctly.")
    print("")
    print("")
    print("----------")
    print("")
    print("")
end
print('Running m.l...')
m.l()
print('Defining m.r()')
function m.r(dt)
    --[[
        Main runtime function
    --]]
end
print('libs.main done.')