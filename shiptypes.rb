require './ship'

# Aircraft Carrier
class AircraftCarrier < Ship
  LENGTH = 5

  def initialize( grid, positions = nil )
    super( grid, positions, LENGTH )
  end

  def name
    'Aircraft Carrier'
  end
end

# Battleship
class Battleship < Ship
  LENGTH = 4

  def initialize( grid, positions = nil )
    super( grid, positions, LENGTH )
  end
end

# Cruiser
class Cruiser < Ship
  LENGTH = 3

  def initialize( grid, positions = nil )
    super( grid, positions, LENGTH )
  end
end

# Destroyer
class Destroyer < Ship
  LENGTH = 2

  def initialize( grid, positions = nil )
    super( grid, positions, LENGTH )
  end
end

# Submarine
class Submarine < Ship
  LENGTH = 1

  def initialize( grid, positions = nil )
    super( grid, positions, LENGTH )
  end
end
