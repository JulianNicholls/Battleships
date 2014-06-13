require 'term/ansicolor'

module Battleships
  # One cell in the grid
  class Cell
    include Term::ANSIColor

    attr_reader :state
    attr_accessor :visible

    def initialize( state = :empty, visible = false )
      @state, @visible = state, visible
    end

    def attack
      show
      return false if [:hit, :miss].include? state

      @state = state == :occupied ? :hit : :miss

      state == :hit
    end

    def hide
      self.visible = false
    end

    def show
      self.visible = true
    end

    def shape
      shapes = {
        empty:    ' ',
        occupied: cyan + '+',
        hit:      red + '*',
        miss:     green + 'X'
      }

      visible ? bold + shapes[state] + white : ' '
    end

    def set
      @state = :occupied
    end

    def empty?
      state == :empty || state == :miss
    end
  end
end
