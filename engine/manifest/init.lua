return {
    libraries = {
        {
            "math",
            "vector",
            "table",
            "thirdParty.serial"
        },{
            "string",
            "hook",
            "class",
            "timer",
            "map"
        },{
            "loveVec",
            "assets",
            "graphics",
            "drawQue"
        --    "ui"
        }
    },
    bases = {
        {"base", "engine"},
        {"image", "engine"},
        {"timer", "engine"},
        {"drawable", "engine"}
    },
    assets = {
        "tiles/noTex",
        "tiles/forestFloor",
        "tiles/grass",
        "tiles/rock",
        "tiles/water",
        "splashes/syngyn"
    },
    drawables = {
        "consoleUI",
        "noGameScreen"
    }
}