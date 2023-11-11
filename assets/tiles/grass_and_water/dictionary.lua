return {
    --[[
    Tile orientations:
    North is the X-aligned edge of the tile
    West is the Y-aligned edge of the tile

      W  | nw | N
      sw | C  | ne
      S  | se | E

    Adjacancy award:

      13 | 0  | 19
      0  | 0  | 0
      7  | 0  | 3

    Sum of adjacancies:

      29 | 10 | 23
      22 | 42 | 20
      35 | 32 | 39

    ]]
    grass = {
        center = {
            {
                offset = {0,16},
                verts = {
                    {0,0},
                    {64,0},
                    {64,32},
                    {32,48},
                    {0,32}
                }
            },
            {
                offset = {0,16},
                verts = {
                    {64,0},
                    {128,0},
                    {128,32},
                    {96,48},
                    {64,32}
                }
            },
            {
                offset = {0,16},
                verts = {
                    {128,0},
                    {192,0},
                    {192,32},
                    {160,48},
                    {128,32}
                }
            },
            {
                offset = {0,16},
                verts = {
                    {192,0},
                    {256,0},
                    {256,32},
                    {224,48},
                    {192,32}
                }
            },
        },
        north = {
            sum = 23,
            offset = {0,16},
            verts = {
            }
        },
    }

}