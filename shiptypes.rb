require './ship'

module Battleships
  # Aircraft Carrier
  class AircraftCarrier < Ship
    @length = 5
    PIECE_MAPS = [[0, 1, 2, 3, 4], [6, 7, 8, 9, 10]]
    
#    def initialize( grid, positions = [] )
#      @length = LENGTH
#      super
#    end

    def type
      'Aircraft Carrier'
    end
  end

  # Battleship
  class Battleship < Ship
    @length = 4
    PIECE_MAPS = [[0, 1, 2, 4], [6, 7, 8, 10]]

#    def initialize( grid, positions = [] )
#      @length = LENGTH
#      super
#    end
  end

  # Cruiser
  class Cruiser < Ship
    @length = 3
    PIECE_MAPS = [[0, 2, 4], [6, 8, 10]]

#    def initialize( grid, positions = [] )
#      @length = LENGTH
#      super
#    end
  end

  # Destroyer
  class Destroyer < Ship
    @length = 2
    PIECE_MAPS = [[0, 4], [6, 10]]

#    def initialize( grid, positions = [] )
#      @length = LENGTH
#      super
#    end
  end

  # Submarine
  class Submarine < Ship
    @length = 1
    PIECE_MAPS = [[5], [11]]

#    def initialize( grid, positions = [] )
#      @length = LENGTH
#      super
#    end
  end
end
