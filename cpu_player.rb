require 'gridpos.rb'

module Battleships
  # CPU Player. Initially just a random shot, then adjacent cells after a hit.
  class CPUPlayer
    def initialize(game)
      @game     = game
      @hit_list = []
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
      attack_intelligently

      @game.phase = :player_turn
    end

    def attack_randomly
      pos = GridPos.random_pos until candidate? pos

      attack_and_rate pos
    end

    def attack_intelligently
      return attack_and_rate(@hit_list.shift) unless @hit_list.empty?

      attack_randomly
    end

    def attack_and_rate(pos)
      result_hit = @game.player_grid.attack(pos)

      @game.play(result_hit ? :hit : :miss)
      add_to_hit_list(pos) if result_hit
    end

    def add_to_hit_list(pos)
      [:across, :down].each do |dir|
        [:next, :prev].each do |func|
          adj = GridPos.send(func, pos, dir)
          @hit_list.push(adj) if candidate?(adj) && !@hit_list.include?(adj)
        end
      end
    end

    def candidate?(pos)
      pos && ![:hit, :miss].include?(@game.player_grid.cell_at(pos).state)
    end
  end
end
