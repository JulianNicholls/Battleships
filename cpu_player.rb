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
      if @last_hit_pos
        attack_intelligently
      else
        attack_randomly
      end

      @game.phase = :player_turn
    end

    def attack_randomly
      pos = GridPos.random_pos until candidate? pos

      attack_and_rate pos
    end

    def attack_intelligently
      pos = GridPos.next( @last_hit_pos, :across )
      return attack_and_rate( pos ) if candidate? pos

      pos = GridPos.prev( @last_hit_pos, :across )
      return attack_and_rate( pos ) if candidate? pos

      pos = GridPos.next( @last_hit_pos, :down )
      return attack_and_rate( pos ) if candidate? pos

      pos = GridPos.prev( @last_hit_pos, :down )
      return attack_and_rate( pos ) if candidate? pos
    end

    def attack_and_rate( pos )
      result_hit = @game.player_grid.attack( pos )

      @game.play( result_hit ? :hit : :miss )
      @last_hit_pos = result_hit ? pos : nil
    end

    def candidate?( pos )
      pos && ![:hit, :miss].include?( @game.player_grid.cell_at( pos ).state )
    end
  end
end
