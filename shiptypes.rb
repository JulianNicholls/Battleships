require './ship'

module Battleships
  # Aircraft Carrier
  class AircraftCarrier < Ship
    @length = 5
    @piece_maps = [[0, 1, 2, 3, 4], [6, 7, 8, 9, 10]]

    def type
      'Aircraft Carrier'
    end
  end

  # Battleship
  class Battleship < Ship
    @length = 4
    @piece_maps = [[0, 1, 2, 4], [6, 7, 8, 10]]
  end

  # Cruiser
  class Cruiser < Ship
    @length = 3
    @piece_maps = [[0, 2, 4], [6, 8, 10]]
  end

  # Destroyer
  class Destroyer < Ship
    @length = 2
    @piece_maps = [[0, 4], [6, 10]]
  end

  # Submarine
  class Submarine < Ship
    @length = 1
    @piece_maps = [[5], [11]]
  end
end
