module Battleships
  # Generic Ship
  class Ship
    attr_reader :length
    attr_accessor :parts
    
    def initialize( grid, positions = [] )
      fail "Position list wrong length #{positions.length}, should be #{length}" \
        unless positions.empty? || positions.size == length

      @grid  = grid
      @parts = positions
    end

    def type
      self.class.to_s.split( '::' ).last
    end

    def sunk?
      parts.all? { |pos| @grid.cell_at( pos ).state == :hit }
    end
  end
end
