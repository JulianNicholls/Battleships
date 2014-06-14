require './constants'

module Battleships
  # Grid position traverser
  class GridPos
    include Constants

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
      nnext = GridPos.prev( pos, :across )
      neighs = nnext.nil? ? [] : [nnext]

      nnext = GridPos.next( pos, :across )
      neighs << nnext unless nnext.nil?

      nnext = GridPos.prev( pos, :down )
      neighs << nnext unless nnext.nil?

      nnext = GridPos.next( pos, :down )
      neighs << nnext unless nnext.nil?

      neighs
    end

    def self.pos_from_point( tlc, point )
      offset = point.offset( -tlc.x, -tlc.y )
      row = (offset.y / CELL_SIZE.height).floor
      col = (offset.x / CELL_SIZE.width).ceil

      return nil unless row.between?( 0, 9 ) && col.between?( 1, 10 )

      ROWS[row] + col.to_s
    end
  end
end
