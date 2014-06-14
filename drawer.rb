require 'gosu_enhanced'

require 'constants'

module Battleships
  # Game drawer
  class Drawer
    include Constants
    include GosuEnhanced

    ROWS = 'ABCDEFGHIJ'

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

      draw_grid( @window.computer_grid, COMPUTER_GRID )

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

    def draw_grid( grid, tlc_pos )
      ROWS.each_char do |row|
        (1..10).each do |col|
          pos = "#{row}#{col}"
          cell = grid.cell_at pos

          next unless cell.visible || cell.state == :empty

          draw_cell( grid, tlc_pos, pos )
        end
      end
    end

    def draw_cell( grid, tlc_pos, pos )
      point = grid_point( tlc_pos, pos )
      ship  = grid.ship_at pos

      unless ship.nil?
        num = ship.piece_number pos
        @window.image[:ship][num].draw( point.x, point.y, 3 )
      end

      cell = grid.cell_at pos

      @window.image[:ship][12].draw( point.x, point.y, 4 ) if cell.state == :miss
      @window.image[:ship][13].draw( point.x, point.y, 4 ) if cell.state == :hit
    end

    def grid_point( tlc, pos )
      tlc.offset(
        (pos[1..-1].to_i - 1) * CELL_SIZE.width,
        (ROWS.index pos[0]) * CELL_SIZE.height
      )
    end
  end
end
