#!/usr/bin/env ruby -I.

require 'constants'
require 'resources'

module Battleships
  # Battleships game
  class Game < Gosu::Window
    include GosuEnhanced
    include Constants

    attr_reader :font, :image

    def initialize
      super( WIDTH, HEIGHT, false, 100 )

      load_resources
    end

    def update
    end

    def draw
      background
      header
      title
      grids
    end

    private

    def load_resources
      loader = ResourceLoader.new( self )
      @font   = loader.fonts
      @image  = loader.images
    end

    def background
      origin  = Point.new( 0, 0 )
      size    = Size.new( WIDTH, HEIGHT )

      draw_rectangle( origin, size, 0, BORDER )

      origin.move_by!( MARGIN, 2 * MARGIN + HEADER_HEIGHT )
      size.deflate!( 2 * MARGIN, 3 * MARGIN + HEADER_HEIGHT )
      draw_rectangle( origin, size, 0, BLACK )

      @image[:waves1].draw( COMPUTER_GRID.x, COMPUTER_GRID.y, 1 )
      @image[:waves2].draw( PLAYER_GRID.x, PLAYER_GRID.y, 1 )
    end

    def header
      font = @font[:header]
      text = 'Battleships'
      size = Size.new( WIDTH - 2 * MARGIN, HEADER_HEIGHT )
      pos  = font.centred_in( text, size )

      font.draw( text, pos.x + MARGIN, pos.y + MARGIN, 1, 1, 1, HEADER_TEXT )
    end

    def title
      font = @font[:title]

    end

    def grids
      lines( COMPUTER_GRID )
      lines( PLAYER_GRID )
    end

    def lines( tlc_pos )
      pos_x = tlc_pos.dup
      pos_y = tlc_pos.dup

      vert = Size.new( 1, GRID_HEIGHT )
      horz = Size.new( GRID_WIDTH, 1 )

      loop do
        draw_rectangle( pos_x, vert, 2, GRID_LINE )
        draw_rectangle( pos_y, horz, 2, GRID_LINE )

        pos_x.move_by!( CELL_SIZE.width, 0 )
        pos_y.move_by!( 0, CELL_SIZE.width )

        break if pos_x.x > tlc_pos.x + GRID_WIDTH
      end
    end
  end
end

Battleships::Game.new.show