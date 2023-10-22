local UI = {}


UI.base = "e_base"
UI.type = "value"
UI.pos = v()
UI.size = v(120,30)
UI.colours = {}
UI.frame = "No frame?"
UI.data = {}
UI.funcArray = {
    value = require("engine.classes.bases.ui.value"),
    button = require("engine.classes.bases.ui.button"),
    check = require("engine.classes.bases.ui.check"),
    slider = require("engine.classes.bases.ui.slider"),
    increment = require("engine.classes.bases.ui.increment"),
    drop = {},
    input = {},
    dialdisplay = {}
}
function UI:init()
    self.draw = UI.funcArray[string.lower(self.type)].draw
end
return UI