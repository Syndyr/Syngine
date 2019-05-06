e.misc = {
}

function e.misc.saveEngineState()
    print("Serialising the engine state..")
    local engine = Tserial.pack(e, true, true)
    local fileName = love.math.random(100000, 999999)
    local rfn = love.filesystem.getSaveDirectory().."/"..fileName..".txt"
    love.filesystem.write(fileName..".txt", engine)
    love.system.setClipboardText(rfn)
    print("Engine snapshot saved.\nFilepath to log file sent to clipboard")
end
