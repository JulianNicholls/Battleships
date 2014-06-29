require 'constants'

module Battleships
  # Holding place for the buttons
  class ButtonHolder
    include Constants

    attr_reader :insert, :cancel

    def initialize( game )
      approx_width = game.font[:button].text_width( 'Cancel' ) * 2
      insert_pos   = Point.new( WIDTH - approx_width, INFO_AREA.y + 20 )
      cancel_pos   = insert_pos.offset( -approx_width, 0 )

      @insert = TextButton.new( game, insert_pos, BUTTON, 'Place' )
      @cancel = TextButton.new( game, cancel_pos, BUTTON, 'Cancel' )
    end

    def draw
      @insert.draw
      @cancel.draw
    end

    def show
      @insert.show
      @cancel.show
    end

    def hide
      @insert.hide
      @cancel.hide
    end
  end
end
