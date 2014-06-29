require 'constants'

module Battleships
  # Place ships for user
  class ShipPlacer
    include Constants

    def initialize( game )
      @game     = game
      @ship_idx = 0

      next_ship
    end

    def update( position )
      update_placing( position )    if @game.phase == :placing
      update_placement( position )  if @game.phase == :placement
    end

    def current
      @cur_ship.type
    end

    private

    def update_placement( position )
      grid_pos = GridPos.pos_from_point( PLAYER_GRID, position )

      insert_ship( grid_pos ) unless grid_pos.nil?
    end

    def update_placing( position )
      rotate_ship if @cur_ship.at? GridPos.pos_from_point( PLAYER_GRID, position )
      finish_ship if @game.buttons.insert.contains? position
      cancel_ship if @game.buttons.cancel.contains? position
    end

    def insert_ship( pos )
      parts = [pos]

      (1...@cur_ship.length).each do |n|
        parts[n] = GridPos.next( parts[n - 1], :across )
        return if parts[n].nil?
      end

      @cur_ship.parts = parts
      @game.player_grid.add_ship @cur_ship
      @game.phase = :placing
      @position = nil
      @game.buttons.show
    end

    def rotate_ship
      @game.player_grid.remove_ship @cur_ship
      @cur_ship.swap_orientation
      @game.player_grid.add_ship @cur_ship
    end

    def finish_ship
      @ship_idx += 1
      next_ship
    end

    def cancel_ship
      @game.player_grid.remove_ship @cur_ship
      next_ship
    end

    def next_ship
      ship_type = @game.ship_class( @ship_idx )

      if ship_type.nil?
        @game.phase = :player_turn
      else
        @cur_ship = ship_type.new( @game.player_grid )
        @game.phase = :placement
      end

      @game.buttons.hide
    end
  end
end
