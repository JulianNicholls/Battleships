require 'gosu_enhanced'

require 'constants'

module Battleships
  # Show a completed window
  class CompleteOverlay
    include Constants

    def initialize( game, victor )
      @game   = game
      @victor = victor
      @header = game.font[:header]
      @title  = game.font[:title]
      @ins    = game.font[:info]

      @size   = Size.new( WIDTH * 2 / 3, HEIGHT / 2 )
      @pos    = Point.new( WIDTH / 6, HEIGHT / 3 )
    end

    def draw
      @game.draw_rectangle( @pos.offset( -10, -10 ), @size.inflate( 20, 20 ),
                            5, SHADOW )

      @game.draw_rectangle( @pos, @size, 5, OVERLAY_BG )

      draw_header
      draw_instructions
    end

    private

    def draw_header
      complete  = 'The battle is over'
      hsize     = @header.measure( complete )
      hpos      = @pos.offset( (@size.width - hsize.width) / 2, hsize.height )

      @header.draw( complete, hpos.x, hpos.y, 6, 1, 1, BACKGROUND )

      complete  = "#{@victor} has won."
      tsize     = @title.measure( complete )
      hpos      = @pos.offset( (@size.width - tsize.width) / 2, hsize.height * 3 )

      @title.draw( complete, hpos.x, hpos.y, 6, 1, 1, BACKGROUND )
    end

    def draw_instructions
      text  = 'Press Escape to Exit'
      tsize = @ins.measure( text )
      hpos  = @pos.offset( (@size.width - tsize.width) / 2,
                           @size.height - tsize.height * 4 )

      @ins.draw( text, hpos.x, hpos.y, 6, 1, 1, BORDER )

      text  = 'Press R to Restart'
      tsize = @ins.measure( text )
      hpos  = @pos.offset( (@size.width - tsize.width) / 2,
                           @size.height - tsize.height * 5 / 2 )

      @ins.draw( text, hpos.x, hpos.y, 6, 1, 1, BORDER )
    end
  end
end
