module Battleships
  # Generic Ship
  class Ship
    @length = 0
    attr_accessor :parts

# These two functions seem convoluted, but I think I'm being smart...

    class << self
      attr_reader :length
    end
    
    def length
      self.class.length
    end
    
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

    def at?( pos )
      parts.include? pos
    end
  end
end
