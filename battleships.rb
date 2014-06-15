#!/usr/bin/env ruby -I.

require 'constants'
require 'resources'
require 'drawer'
require 'shiptypes'

module Battleships
  # Battleships game
  class Game < Gosu::Window
    include Constants

    SHIPS = [AircraftCarrier, Battleship, Cruiser,
             Destroyer, Destroyer, Submarine, Submarine]

    KEY_FUNCS = {
      Gosu::KbEscape  => -> { close },
      Gosu::KbR       => -> { reset },

      Gosu::MsLeft    => -> { @position = Point.new( mouse_x, mouse_y ) }
    }

    attr_reader :font, :image, :computer_grid, :player_grid

    def initialize
      super( WIDTH, HEIGHT, false, 100 )
      self.caption = 'Battleships'

      load_resources
      @drawer = Drawer.new( self )

      reset
    end

    def needs_cursor?   # Enable the mouse cursor
      true
    end

    def update
      return unless @position

      player_grid_pos = GridPos.pos_from_point( PLAYER_GRID, @position )
      cpu_grid_pos    = GridPos.pos_from_point( COMPUTER_GRID, @position )

      @computer_grid.attack cpu_grid_pos unless cpu_grid_pos.nil?

      @position = nil
    end

    def draw
      @drawer.background
      @drawer.header
      @drawer.title
      @drawer.grids

      @font[:info].draw( SHIPS[@ship_idx].to_s, INFO_AREA.x, INFO_AREA.y, 2, 1, 1, INFO )
    end

    def button_down( btn_id )
      instance_exec( &KEY_FUNCS[btn_id] ) if KEY_FUNCS.key? btn_id
    end

    private

    def reset
      fill_computer_grid

      @player_grid  = Grid.new :visible
      @phase        = :placement
      @ship_idx     = 0
    end

    def load_resources
      loader = ResourceLoader.new( self )
      @font   = loader.fonts
      @image  = loader.images
    end

    def fill_computer_grid
      @computer_grid = Grid.new

      SHIPS.each { |ship| @computer_grid.add_ship ship.new( @computer_grid ) }
    end
  end
end

Battleships::Game.new.show
