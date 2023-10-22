local t = {
    __title = "Isometric tile library",
    __description = "Provides isometric tile rendering",
    __author = "Connor Day",
    __version = 1,
    size = v(128,64),
}

t.points = {
    t.size * v(0.5, 0),
    t.size * v(1, 0.5),
    t.size * v(0.5, 1),
    t.size * v(0, 0.5)
}

t.uvs = {
    v(0, 0),
    v(1, 0),
    v(1, 1),
    v(0, 1)
}

t.tileMesh = love.graphics.newMesh(
    {
        {t.points[1].x, t.points[1].y, t.uvs[1].x, t.uvs[1].y, 1, 1, 1, 1},
        {t.points[2].x, t.points[2].y, t.uvs[2].x, t.uvs[2].y, 1, 1, 1, 1},
        {t.points[3].x, t.points[3].y, t.uvs[3].x, t.uvs[3].y, 1, 1, 1, 1},
        {t.points[4].x, t.points[4].y, t.uvs[4].x, t.uvs[4].y, 1, 1, 1, 1}
    }, 
    "fan", 
    "static"
)
t.aspectRatio = t.size.x/t.size.y

function t:getWorldCoordinate(pos)
    
end

return t