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
      @text   = game.font[:title]

      @size     = Size.new( WIDTH / 2, HEIGHT / 2 )
      @pos      = Point.new( WIDTH / 4, HEIGHT / 3 )
    end

    def draw
      @game.draw_rectangle( @pos.offset( -10, -10 ), @size.inflate( 20, 20 ),
                            5, SHADOW )

      @game.draw_rectangle( @pos, @size, 5, OVERLAY_BG )

      draw_text
    end

    private

    def draw_text
      complete  = 'Complete'
      hsize     = @header.measure( complete )
      hpos      = @pos.offset( (@size.width - hsize.width) / 2, hsize.height / 2 )

      @header.draw( complete, hpos.x, hpos.y, 6, 1, 1, BACKGROUND )

      complete  = "#{@victor} has won."
      tsize     = @text.measure( complete )
      hpos      = @pos.offset( (@size.width - tsize.width) / 2, hsize.height * 3 )

      @text.draw( complete, hpos.x, hpos.y, 6, 1, 1, BACKGROUND )
    end
  end
end
