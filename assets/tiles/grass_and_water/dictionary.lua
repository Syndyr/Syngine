return {
    --[[
    Tile orientations:
    North is the X-aligned edge of the tile
    West is the Y-aligned edge of the tile

      W  | nw | N
      sw | C  | ne
      S  | se | E

    Adjacancy award:
    Only check diagonals if the tile is a center tile
      13 | 17 | 19
      11 | 0  | 2
      7  | 5  | 3

    Sum of adjacancies:
    

      29 | 10 | 23
      22 | 42 | 20
      35 | 32 | 39
      
      8 nw-se = 55 
      8 sw-ne = 64
    figureEightNorthWestBySouthEast
    figureEightSouthWestByNorthEast
    {
        [-1] = { 13, 17, 19 },
        [0] = { 11, 0, 2 },
        [1] = { 7, 5, 3 }
    }

    ]]
    grass = {
        center = {
            sum = 42,
            {
                offset = {0,16},
                verts = {
                    {0,0},
                    {64,0},
                    {64,64},
                    {0,64},
                }
            },
            {
                offset = {0,16},
                verts = {
                    {64,0},
                    {128,0},
                    {128,64},
                    {0,64}
                }
            },
            {
                offset = {0,16},
                verts = {
                    {128,0},
                    {192,0},
                    {192,64},
                    {128,64},
                }
            },
            {
                offset = {0,16},
                verts = {
                    {192,0},
                    {256,0},
                    {256,64},
                    {192,64}
                }
            },
        },
        northEast = {
            sum = 20,
            {
                offset = {0,16},
                verts = {
                    {192,64},
                    {256,64},
                    {256,128},
                    {192,128}
                }
            }
        },
        southEast = {
            sum = 23,
            {
                offset = {0,16},
                verts = {
                    {0,64},
                    {64,64},
                    {64,128},
                    {0,128}
                }
            }
        },
        southWest = {
            sum = 32,
            {
                offset = {0,16},
                verts = {
                    {64,64},
                    {128,64},
                    {128,128},
                    {64,128}
                }
            }
        },
        northWest = {
            sum = 10,
            {
                offset = {0,16},
                verts = {
                    {128,64},
                    {192,64},
                    {192,128},
                    {128,128}
                }
            }
        }
    },
    water = {
        center = {
            sum = 42,
            {
                offset = {0,16},
                verts = {
                    {192,320},
                    {256,320},
                    {256,384},
                    {192,384}
                }
            },
            {
                offset = {0,16},
                verts = {
                    {128,320},
                    {192,320},
                    {192,384},
                    {128,384}
                }
            }
        },
        north = {
            sum = 23,
            {
                offset = {0,16},
                verts = {
                    {0,192},
                    {64,192},
                    {64,256},
                    {0,256}
                }
            },
            {
                offset = {0,16},
                verts = {
                    {0,256},
                    {64,256},
                    {64,320},
                    {0,320}
                }
            }
        },
        northEast = {
            sum = 20,
            {
                offset = {0,16},
                verts = {
                    {64,128},
                    {128,128},
                    {128,256},
                    {64,256}
                }
            }
        },
        east = {
            sum = 39,
            {
                offset = {0,16},
                verts = {
                    {64,192},
                    {128,192},
                    {128,256},
                    {64,256}
                }
            }
        },
        southEast = {
            sum = 32,
            {
                offset = {0,16},
                verts = {
                    {128,128},
                    {192,128},
                    {192,192},
                    {128,192}
                }
            }
        },
        south = {
            sum = 35,
            {
                offset = {0,16},
                verts = {
                    {128,192},
                    {192,192},
                    {192,256},
                    {128,256}
                }
            },
            {
                offset = {0,16},
                verts = {
                    {128,256},
                    {192,256},
                    {192,320},
                    {128,320}
                }
            }
        },
        southWest = {
            sum = 22,
            {
                offset = {0,16},
                verts = {
                    {192, 128},
                    {256, 128},
                    {256, 192},
                    {192, 192}
                }
            }
        },
        west = {
            sum = 29,
            {
                offset = {0,16},
                verts = {
                    {192,192},
                    {256,192},
                    {256,256},
                    {192,256}
                }
            },
            {
                offset = {0,16},
                verts = {
                    {192,256},
                    {256,256},
                    {256,320},
                    {192,320}
                }
            }
        },
        northWest = {
            sum = 10,
            {
                offset = {0,16},
                verts = {
                    {0,128},
                    {64,128},
                    {64,256},
                    {0,256}
                }
            }
        },
        figureEightNorthWestBySouthEast = {
            sum = 55,
            {
                offset = {0,16},
                verts = {
                    {64,320},
                    {128,320},
                    {128,384},
                    {64,384}
                }
            }
        },
        figureEightSouthWestByNorthEast= {
            sum = 64,
            {
                offset = {0,16},
                verts = {
                    {0,320},
                    {64,320},
                    {64,384},
                    {0,384}
                }
            }
        }
    }
}