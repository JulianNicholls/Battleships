#!/usr/bin/env ruby -I.

require 'constants'
require 'resources'
require 'drawer'
require 'shiptypes'
require 'button'

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
      create_buttons

      reset
    end

    def needs_cursor?   # Enable the mouse cursor
      true
    end

    def update
      update_thinking if @phase == :thinking
      update_cpu_turn if @phase == :cpu_turn
      
      return unless @position

      update_placing      if @phase == :placing
      update_placement    if @phase == :placement
      update_player_turn  if @phase == :player_turn

      @position = nil
    end

    def draw
      @drawer.background
      @drawer.header
      @drawer.title
      @drawer.grids

      draw_instructions
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
      next_ship
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

      @computer_grid.attack grid_pos unless grid_pos.nil?
      @phase = :thinking
      @think_time = Time.now + 1 + 2 * rand
    end
    
    def update_thinking
      return if Time.now < @think_time
      
      @phase = :cpu_turn
    end
    
    def update_cpu_turn
      pos = ''
      
      loop do
        pos   = GridPos.random_pos
        state = @player_grid.cell_at( pos ).state
        
        break unless state == :miss || :state == :hit
      end
      
      @player_grid.attack pos
      @phase = :player_turn
    end

    def draw_instructions
      ins_text = case @phase
      when :placement then  "Click to place a #{@cur_ship.type}"
      when :placing   then  'Click ship to swap between across and down'
      when :player_turn   then  'Click on computer grid to attack'
      when :thinking  then  'Thinking...'
      end

      @font[:info].draw( ins_text, INFO_AREA.x, INFO_AREA.y, 2, 1, 1, INFO )
      @btn_insert.draw
      @btn_cancel.draw
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
      @btn_insert = TextButton.new(
        self, INFO_AREA.offset( 300, 20 ), BUTTON, 'Insert'
      )

      @btn_cancel = TextButton.new(
        self, INFO_AREA.offset( 300 - @btn_insert.width * 1.5, 20 ),
        BUTTON, 'Cancel'
      )
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
