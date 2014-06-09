# One cell in the grid

require 'term/ansicolor'

module Battleships
  class Cell
    include Term::ANSIColor
    
    CHARS = { empty: ' ', occupied: '+', hit: '*', miss: 'X' }

    attr_reader :state
    attr_accessor :visible

    def initialize( state = :empty, visible = false )
      @state, @visible = state, visible
    end

    def attack
      show
      return false if state == :hit || state == :miss

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
      visible ? CHARS[state] : ' '
    end

    def set
      @state = :occupied
    end

    def empty?
      state == :empty || state == :miss
    end
  end
end