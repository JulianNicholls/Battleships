#!/usr/bin/env ruby -I.

require 'resources'
require 'drawer'
require 'shiptypes'
require 'constants'
require 'placer'
require 'button'
require 'cpu_player'
require 'overlay'
require 'holder'

module Battleships
  # Battleships game
  class Game < Gosu::Window
    include Constants

    KEY_FUNCS = {
      Gosu::KbEscape  => -> { close if @overlay },
      Gosu::KbR       => -> { reset if @overlay },

      Gosu::MsLeft    => -> { @position = Point.new(mouse_x, mouse_y) }
    }

    SHIPS = [AircraftCarrier, Battleship, Cruiser, Cruiser,
             Destroyer, Destroyer, Submarine, Submarine]

    attr_reader :font, :image, :computer_grid, :player_grid, :sound, :buttons
    attr_accessor :phase

    def initialize
      super(WIDTH, HEIGHT, false, 100)
      self.caption = 'Gosu Battleships'

      load_resources

      @buttons    = ButtonHolder.new(self)
      @drawer     = Drawer.new(self)
      @cpu_player = CPUPlayer.new(self)

      reset
    end

    def needs_cursor?   # Enable the mouse cursor
      true
    end

    def update
      update_complete?
      @cpu_player.update
      update_positional unless @position.nil?
    end

    def draw
      @drawer.background
      @drawer.header
      @drawer.title
      @drawer.grids

      return @overlay.draw if @overlay

      @drawer.instructions @placer.current

      @buttons.draw
    end

    def button_down(btn_id)
      instance_exec(&KEY_FUNCS[btn_id]) if KEY_FUNCS.key? btn_id
    end

    def play(sound)
      @sound[sound].play
    end

    def ship_class(num)
      return nil unless num < SHIPS.size

      SHIPS[num]
    end

    private

    def reset
      fill_computer_grid

      @player_grid  = Grid.new :visible
      @placer       = ShipPlacer.new self
      @overlay      = nil
    end

    def load_resources
      loader  = ResourceLoader.new(self)

      @font   = loader.fonts
      @image  = loader.images
      @sound  = loader.sounds
    end

    def fill_computer_grid
      @computer_grid = Grid.new

      SHIPS.each { |ship| @computer_grid.add_ship ship.new(@computer_grid) }
    end

    def update_complete?
      return unless @player_grid.complete? || @computer_grid.complete?

      cpu_won     = @player_grid.complete?
      @overlay    = CompleteOverlay.new(self, cpu_won ? 'Computer' : 'Player')
      self.phase  = :complete
    end

    def update_positional
      if phase == :player_turn
        update_player_turn
      elsif [:placing, :placement].include? phase
        @placer.update(@position)
      end

      @position = nil
    end

    def update_player_turn
      grid_pos = GridPos.pos_from_point(COMPUTER_GRID, @position)

      return if grid_pos.nil? || @computer_grid.cell_at(grid_pos).visible

      play(@computer_grid.attack(grid_pos) ? :hit : :miss)

      @cpu_player.set_thinking
    end
  end
end

Battleships::Game.new.show
