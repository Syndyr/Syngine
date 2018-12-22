return {
    libraries = {
        {
            "math",
            "vector",
            "table",
            "serial"
        },{
            "string",
            "hook",
            "class",
            "timer"
        },{
            "map"
        --    "main"
        },{
            "loveVec",
            "assets"
        --    "keypress",
        --    "ui"
        }
    },
    bases = {
        {"base", "engine"},
        {"image", "engine"},
        {"timer", "engine"}
    },
    assets = {
         "tiles/noTex",
         "tiles/forestFloor",
         "tiles/grass",
         "tiles/rock",
         "tiles/water"
    }
}