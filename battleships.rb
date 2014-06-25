#!/usr/bin/env ruby -I.

require 'constants'
require 'resources'
require 'drawer'
require 'shiptypes'
require 'button'
require 'cpu_player'
require 'overlay'

module Battleships
  # Battleships game
  class Game < Gosu::Window
    include Constants

    SHIPS = [AircraftCarrier, Battleship, Cruiser, Cruiser,
             Destroyer, Destroyer, Submarine, Submarine]

    KEY_FUNCS = {
      Gosu::KbEscape  => -> { close if @overlay },
      Gosu::KbR       => -> { reset if @overlay },

      Gosu::MsLeft    => -> { @position = Point.new( mouse_x, mouse_y ) }
    }

    attr_reader :font, :image, :computer_grid, :player_grid, :sound
    attr_accessor :phase

    def initialize
      super( WIDTH, HEIGHT, false, 100 )
      self.caption = 'Gosu Battleships'

      load_resources
      create_buttons

      @drawer     = Drawer.new( self )
      @cpu_player = CPUPlayer.new( self )

      reset
    end

    def needs_cursor?   # Enable the mouse cursor
      true
    end

    def update
      update_complete?
      @cpu_player.update
      update_positional
    end

    def draw
      @drawer.background
      @drawer.header
      @drawer.title
      @drawer.grids

      return @overlay.draw if @overlay

      @drawer.instructions @cur_ship.type

      draw_buttons
    end

    def button_down( btn_id )
      instance_exec( &KEY_FUNCS[btn_id] ) if KEY_FUNCS.key? btn_id
    end

    def play( sound )
      @sound[sound].play
    end

    private

    def reset
      fill_computer_grid

      @player_grid  = Grid.new :visible
      @phase        = :placement
      @ship_idx     = 0
      next_ship

      @overlay = nil
    end

    def load_resources
      loader  = ResourceLoader.new( self )

      @font   = loader.fonts
      @image  = loader.images
      @sound  = loader.sounds
    end

    def fill_computer_grid
      @computer_grid = Grid.new

      SHIPS.each { |ship| @computer_grid.add_ship ship.new( @computer_grid ) }
    end

    def update_complete?
      return unless @player_grid.complete? || @computer_grid.complete?

      cpu_won  = @player_grid.complete?
      @overlay = CompleteOverlay.new( self, cpu_won ? 'Computer' : 'Player' )
      @phase   = :complete
    end

    def update_positional
      return if @position.nil?

      case @phase
      when :placing     then update_placing
      when :placement   then update_placement
      when :player_turn then update_player_turn
      end

      @position = nil
    end

    def update_placement
      grid_pos = GridPos.pos_from_point( PLAYER_GRID, @position )

      insert_ship( grid_pos ) unless grid_pos.nil?
    end

    def update_placing
      rotate_ship if @cur_ship.at? GridPos.pos_from_point( PLAYER_GRID, @position )
      finish_ship if @btn_insert.contains? @position
      cancel_ship if @btn_cancel.contains? @position
    end

    def update_player_turn
      grid_pos = GridPos.pos_from_point( COMPUTER_GRID, @position )

      return if grid_pos.nil?

      play( @computer_grid.attack( grid_pos ) ? :hit : :miss )

      @cpu_player.set_thinking
    end

    def insert_ship( pos )
      parts = [pos]

      (1..@cur_ship.length - 1).each do |n|
        parts[n] = GridPos.next( parts[n - 1], :across )
        return if parts[n].nil?
      end

      @cur_ship.parts = parts
      @player_grid.add_ship @cur_ship
      @phase = :placing
      @position = nil
      show_buttons
    end

    def rotate_ship
      @player_grid.remove_ship @cur_ship
      @cur_ship.swap_orientation
      @player_grid.add_ship @cur_ship
    end

    def finish_ship
      @ship_idx += 1
      next_ship
    end

    def cancel_ship
      @player_grid.remove_ship @cur_ship
      next_ship
    end

    def next_ship
      if @ship_idx < SHIPS.size
        @cur_ship = SHIPS[@ship_idx].new( @player_grid )
        @phase = :placement
      else
        @phase = :player_turn
      end

      hide_buttons
    end

    def create_buttons
      approx_width = @font[:button].text_width( 'Cancel' ) * 2
      insert_pos   = Point.new( WIDTH - approx_width, INFO_AREA.y + 20 )
      cancel_pos   = insert_pos.offset( -approx_width, 0 )

      @btn_insert = TextButton.new( self, insert_pos, BUTTON, 'Place' )
      @btn_cancel = TextButton.new( self, cancel_pos, BUTTON, 'Cancel' )
    end

    def draw_buttons
      @btn_insert.draw
      @btn_cancel.draw
    end

    def show_buttons
      @btn_insert.show
      @btn_cancel.show
    end

    def hide_buttons
      @btn_insert.hide
      @btn_cancel.hide
    end
  end
end

Battleships::Game.new.show
