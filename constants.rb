require 'gosu_enhanced'

module Battleships
  # Constants for the crossword game
  module Constants
    include GosuEnhanced

    MARGIN        = 5
    
    HEADER_HEIGHT = 40
    
    TITLE_TOP     = 4 * MARGIN + HEADER_HEIGHT
    TITLE_HEIGHT  = 30
    
    CELL_SIZE     = Size.new( 30, 30 )
    
    GRID_WIDTH    = 10 * CELL_SIZE.width
    GRID_HEIGHT   = 10 * CELL_SIZE.height

    COMPUTER_GRID = Point.new( MARGIN * 3, TITLE_TOP + TITLE_HEIGHT + MARGIN * 2 )
    PLAYER_GRID   = COMPUTER_GRID.offset( MARGIN * 2 + GRID_WIDTH, 0 )

    WIDTH         = PLAYER_GRID.x + GRID_WIDTH + 3 * MARGIN
    HEIGHT        = 480


    BLACK         = Gosu::Color.new( 0xff000000 )
    BORDER        = Gosu::Color.new( 0xffcc0000 )
    HEADER_TEXT   = Gosu::Color.new( 0xffdddd00 )
    GRID_LINE     = Gosu::Color.new( 0xc0b0b0b0 )
  end
end
