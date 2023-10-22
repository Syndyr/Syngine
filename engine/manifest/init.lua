return {
    libraries = {
        thirdParty = {
            "serial",
            "vector",
            "fuz",
            "loveVec"
        },{
            "math",
            "table"
        },{
            "string",
            "hook",
            "class",
            "timer",
            "map"
        },{
            "asset",
            "graphics",
            "drawQue",
            "keys",
            "ui",
            "misc"
        },{
            "isoTile"
        }
    },
    bases = {
        {"base", "engine"},
        {"image", "engine"},
        {"timer", "engine"},
        {"drawable", "engine"},
        {"uiFrame", "engine"},
        {"testPlayer", "engine"},
        {"isoTile", "engine"}
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
        "noGameScreen",
        "isoTileWorld"
    }
}