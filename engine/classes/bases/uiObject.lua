local UI = {}


UI.base = "e_base"
UI.type = "value"
UI.pos = v()
UI.size = v(120,30)
UI.colors = {
    
    primary = {255,255,255,128},
    secondary = {64,64,64,28},
    terciary = {64,64,64},
    misc = {255,255,200}
    
}
UI.frame = "No frame?"
UI.data = {}
UI.funcArray = {
    value = require("engine.classes.bases.ui.value"),
    button = require("engine.classes.bases.ui.button"),
    check = require("engine.classes.bases.ui.check"),
    slider = {},
    drop = {},
    input = {},
    dialdisplay = {}
}
function UI:init()
    self.draw = UI.funcArray[string.lower(self.type)].draw
end
return UI