require 'gosu_enhanced'

require 'constants'

module Battleships
  # Game drawer
  class Drawer
    include Constants
    include GosuEnhanced

    def initialize( window )
      @window = window
    end

    def background
      origin  = Point.new( 0, 0 )
      size    = Size.new( WIDTH, HEIGHT )

      @window.draw_rectangle( origin, size, 0, BORDER )

      origin.move_by!( MARGIN, 2 * MARGIN + HEADER_HEIGHT )
      size.deflate!( 2 * MARGIN, 3 * MARGIN + HEADER_HEIGHT )
      @window.draw_rectangle( origin, size, 0, BACKGROUND )

      @window.image[:waves1].draw( COMPUTER_GRID.x, COMPUTER_GRID.y, 1 )
      @window.image[:waves2].draw( PLAYER_GRID.x, PLAYER_GRID.y, 1 )
    end

    def header
      font = @window.font[:header]
      text = 'Battleships'
      size = Size.new( WIDTH - 2 * MARGIN, HEADER_HEIGHT )
      pos  = font.centred_in( text, size )

      font.draw( text, pos.x + MARGIN, pos.y + MARGIN, 1, 1, 1, HEADER_TEXT )
    end

    def title
      font = @window.font[:title]
      text = 'Computer'
      pos  = font.centred_in( text, Size.new( GRID_WIDTH, TITLE_HEIGHT ) )
      font.draw( text, COMPUTER_GRID.x + pos.x, TITLE_TOP + pos.y, 1,
                 1, 1, HEADER_TEXT )

      text = 'Player'
      pos  = font.centred_in( text, Size.new( GRID_WIDTH, TITLE_HEIGHT ) )
      font.draw( text, PLAYER_GRID.x + pos.x, TITLE_TOP + pos.y, 1,
                 1, 1, HEADER_TEXT )
    end

    def grids
      lines( COMPUTER_GRID )
      lines( PLAYER_GRID )

      left = 20

      @window.image[:ship].each do |part|
        part.draw( left, 420, 3 )
        left += 33
      end
    end

    def lines( tlc_pos )
      pos_y = pos_x = tlc_pos

      vert = Size.new( 1, GRID_HEIGHT )
      horz = Size.new( GRID_WIDTH, 1 )

      while pos_x.x <= tlc_pos.x + GRID_WIDTH
        @window.draw_rectangle( pos_x, vert, 2, GRID_LINE )
        @window.draw_rectangle( pos_y, horz, 2, GRID_LINE )

        pos_x = pos_x.offset( CELL_SIZE.width, 0 )
        pos_y = pos_y.offset( 0, CELL_SIZE.width )
      end
    end
  end
end
