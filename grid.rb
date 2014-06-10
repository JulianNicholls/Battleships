require './cell'

module Battleships
  # Grid
  class Grid
    ROWS = 'ABCDEFGHIJ'

    def self.next( pos, direction )
      mdata = /\A([A-J])(10|[1-9])\z/.match pos.upcase

      return nil if mdata.nil?

      if direction == :across
        return nil if mdata[2].to_i == 10
        mdata[1] + (mdata[2].to_i + 1).to_s
      else
        return nil if mdata[1] == ROWS[-1]
        mdata[1].next + mdata[2]
      end
    end

    def self.prev( pos, direction )
      mdata = /\A([A-J])(10|[1-9])\z/.match pos.upcase

      return nil if mdata.nil?

      if direction == :across
        return nil if mdata[2].to_i <= 1
        mdata[1] + (mdata[2].to_i - 1).to_s
      else
        return nil if mdata[1] == ROWS[0]
        row = ROWS[ROWS.index( mdata[1] ) - 1]
        row + mdata[2]
      end
    end

    def self.neighbours( pos )
      nnext = Grid.prev( pos, :across )
      neighs = nnext.nil? ? [] : [nnext]

      nnext = Grid.next( pos, :across )
      neighs << nnext unless nnext.nil?

      nnext = Grid.prev( pos, :down )
      neighs << nnext unless nnext.nil?

      nnext = Grid.next( pos, :down )
      neighs << nnext unless nnext.nil?

      neighs
    end

    def initialize( visible = false, width = 10, height = 10 )
      @width, @height = width, height
      @grid = empty_grid( width, height, visible )
    end

    def cell_at( letter, number = nil )
      letter.upcase!

      if letter.size > 1
        row = letter[0].ord - 'A'.ord
        col = letter[1..-1].to_i - 1
      else
        row = letter.ord - 'A'.ord
        col = number.to_i - 1
      end

      @grid[row * @width + col]
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

    private

    def empty_grid( width, height, visible )
      Array.new( width * height ) { Cell.new( :empty, visible ) }
    end

    def top_header
      str = '  '
      (1..10).each { |n| str << format( '%-2d', n ) }
      str + "\n"
    end
  end
end
