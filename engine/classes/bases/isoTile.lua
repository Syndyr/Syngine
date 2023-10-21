local t = {}

t.cid = "iso_tile"
t.size = v(128,64)
t.data = {
    points = {
        v(t.size * v(0.5, 0)),
        v(t.size * v(1, 0.5)),
        v(t.size * v(0.5, 1)),
        v(t.size * v(0, 0.5))
    }
}

return t