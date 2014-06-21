require 'gridpos.rb'

module Battleships
  # CPU Player. Initially just a random shot.
  class CPUPlayer
    def initialize( game )
      @game = game
    end

    def update
      update_attack   if @game.phase == :cpu_turn
      update_thinking if @game.phase == :thinking
    end

    def set_thinking
      @game.phase = :thinking
      @think_time = Time.now + 0.5 + rand
    end

    private

    def update_thinking
      return if Time.now < @think_time

      @game.phase = :cpu_turn
    end

    def update_attack
      pos  = ''
      grid = @game.player_grid

      loop do
        pos   = GridPos.random_pos
        state = grid.cell_at( pos ).state

        break unless [:miss, :hit].include? state
      end

      @game.play( grid.attack( pos ) ? :hit : :miss )
      @game.phase = :player_turn
    end
  end
end
