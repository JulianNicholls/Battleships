require './cell'
require './gridpos'

module Battleships
  # Grid
  class Grid
    ROWS = 'ABCDEFGHIJ'

    attr_reader :ships

    def initialize( visible = false, width = 10, height = 10 )
      @width, @height = width, height
      @grid  = empty_grid( width, height, visible )
      @ships = []
    end

    def add_ship( ship )
      @ships << ship

      if ship.parts.empty?
        insert( ship )
      else
        ship.parts.each { |pos| set pos }
      end
    end

    def cell_at( letter, number = nil )
      letter.upcase!

      if letter.size > 1
        row = ROWS.index letter[0]
        col = letter[1..-1].to_i
      else
        row = ROWS.index letter
        col = number.to_i
      end

      @grid[row * @width + col - 1]
    end

    def to_s( headers = false )
      str = headers ? top_header : ''

      ROWS.each_char do |letter|
        str << "#{letter} " if headers

        (1..10).each do |col|
          str << "#{cell_at( letter, col ).shape} "
        end

        str << "\n"
      end

      str
    end

    def set( row, col = nil )
      cell_at( row, col ).set
    end

    def attack( row, col = nil )
      cell_at( row, col ).attack
    end

    def show
      @grid.map( &:show )
    end

    def ship_at( pos )
      @ships.select { |ship| return ship if ship.at? pos }

      nil
    end

    private

    def empty_grid( width, height, visible )
      Array.new( width * height ) { Cell.new( :empty, visible ) }
    end

    def insert( ship )
      length = ship.length
      poses  = []

      loop do
        dir, cur = random_start_point( length )
        poses = try( length, cur, dir )
        break unless poses.nil?
      end

      poses.each { |pos| cell_at( pos ).set }
      ship.parts = poses
    end

    def random_start_point( length )
      dir = [:across, :down][rand 2]

      if dir == :across
        cur = ROWS[rand @height] + rand( 1..((@width + 1) - length) ).to_s
      else
        cur = ROWS[rand( @height - length )] + rand( 1..@width ).to_s
      end

      [dir, cur]
    end

    def try( length, cur, dir )
      poses = []

      loop do
        break unless isolated?( cur )

        poses << cur
        return poses if poses.size == length
        cur = GridPos.next( cur, dir )
      end

      nil
    end

    def isolated?( pos )
      return false unless cell_at( pos ).empty?

      GridPos.neighbours( pos ).all? { |loc| cell_at( loc ).empty? }
    end

    def top_header
      str = '  '
      (1..10).each { |n| str << format( '%-2d', n ) }
      "#{str}\n"
    end
  end
end
