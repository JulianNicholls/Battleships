require 'gosu_enhanced'

module Battleships
  # Constants for the crossword game
  module Constants
    include GosuEnhanced

    MARGIN        = 7

    HEADER_HEIGHT = 40

    TITLE_TOP     = 4 * MARGIN + HEADER_HEIGHT
    TITLE_HEIGHT  = 30

    CELL_SIZE     = Size.new( 30, 30 )

    GRID_WIDTH    = 10 * CELL_SIZE.width
    GRID_HEIGHT   = 10 * CELL_SIZE.height

    COMPUTER_GRID = Point.new( MARGIN * 3, TITLE_TOP + TITLE_HEIGHT + MARGIN * 2 )
    PLAYER_GRID   = COMPUTER_GRID.offset( MARGIN * 2 + GRID_WIDTH, 0 )
    INFO_AREA     = COMPUTER_GRID.offset( 0, MARGIN * 2 + GRID_HEIGHT )

    WIDTH         = PLAYER_GRID.x + GRID_WIDTH + 3 * MARGIN
    HEIGHT        = INFO_AREA.y + HEADER_HEIGHT + MARGIN * 3

    BACKGROUND    = Gosu::Color.new( 0xff000060 )
    BORDER        = Gosu::Color.new( 0xff004080 )
    HEADER_TEXT   = Gosu::Color.new( 0xffeeee00 )
    GRID_LINE     = Gosu::Color.new( 0xe0b0b0b0 )
    INFO          = Gosu::Color.new( 0xffffffff )
    BUTTON        = Gosu::Color.new( 0xff000020 )
    
    OVERLAY_BG    = Gosu::Color.new( 0xe0ffffff )   # Translucent white
    SHADOW        = Gosu::Color.new( 0x80000000 )
  end
end
