require './grid'

module Battleships
  # Generic Ship
  class Ship
    @length = 0
    attr_reader :parts

    class << self
      attr_reader :length
      attr_reader :piece_maps
    end

    def initialize( grid, positions = [] )
      fail "Position list wrong length #{positions.length}, should be #{length}" \
        unless positions.empty? || positions.size == length

      @map_index = -1
      @grid      = grid
      self.parts = positions
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

    def parts=( poses )
      @parts = poses

      return if poses.empty?

      if poses.size == 1
        @map_index = rand 2   # Submarine, randomly horizontal / vertical
      else
        @map_index = poses[1] == GridPos.next( poses[0], :across ) ? 0 : 1
      end
    end

    def length
      self.class.length
    end

    def piece_number( pos )
      piece_map[parts.index pos]
    end
    
    def swap_orientation
      new_dir = @map_index == 0 ? :down : :across
      parts = [@parts.first]
      
      (1..length - 1).each do |n|
        parts[n] = GridPos.next( parts[n - 1], new_dir )
        return if parts[n].nil?
      end
      
      self.parts = parts
    end

    private

    def piece_map
      self.class.piece_maps[@map_index] if @map_index >= 0
    end
  end
end
