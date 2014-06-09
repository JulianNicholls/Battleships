require 'minitest/autorun'
require 'minitest/pride'

require './shiptypes'

# Ship is not designed to be instantiated as itself

describe Ship do
  let( :grid ) { Grid.new :visible }

  describe '#initialize' do
    it 'should be initializable with a random position' do
      Ship.new( grid, nil, 5 )
    end

    it 'should be initializable with a set of positions' do
      Ship.new( grid, %w(A1 A2 A3 A4), 4 )
    end

    it 'should throw an error if the position list is the wrong size' do
      proc { Ship.new( grid, %w(A1 A2 A3 A4), 3 ) }.must_raise RuntimeError
    end
  end

  describe '#type' do
    it 'should return its type' do
      Ship.new( grid, nil, 5 ).type.must_equal 'Ship'
    end
  end

  describe '#parts' do
    it 'should return the grid positions the ship occupies' do
      poses = %w(A1 A2 A3 A4)

      bs = Ship.new( grid, poses, 4 )
      bs.parts.must_equal poses
    end
  end

  describe 'Ship#insert_into' do
    it 'should put the ship into the grid somewhere' do
      bs = Ship.new( grid, nil, 4 )

      bs.parts.each { |pos| grid.cell_at( pos ).state.must_equal :occupied }
    end
  end

  describe 'Ship#sunk?' do
    it 'should return false if any part is not hit' do
      bs   = Ship.new( grid, nil, 4 )
      most = bs.parts[1..-1]

      most.each do |pos|
        grid.attack( pos )
        bs.sunk?.must_equal false
      end
    end

    it 'should not return true if any part is not hit' do
      bs  = Ship.new( grid, nil, 4 )

      bs.parts.each { |pos| grid.attack( pos ) }

      bs.sunk?.must_equal true
    end
  end
end

describe AircraftCarrier do
  let( :grid ) { Grid.new }

  describe '#initialize' do
    it 'should be initializable with a random position' do
      AircraftCarrier.new( grid )
    end

    it 'should be initializable with a set of positions' do
      AircraftCarrier.new( grid, %w(A1 A2 A3 A4 A5) )
    end

    it 'should throw an error if the position list is the wrong size' do
      proc { AircraftCarrier.new( grid, %w(A1 A2 A3 A4) ) }.must_raise RuntimeError
    end
  end

  describe '#type' do
    it 'should return its type' do
      AircraftCarrier.new( grid ).type.must_equal 'Aircraft Carrier'
    end
  end
end

describe Battleship do
  let( :grid ) { Grid.new :visible }

  describe '#initialize' do
    it 'should be initializable with a random position' do
      Battleship.new( grid )
    end

    it 'should be initializable with a set of positions' do
      Battleship.new( grid, %w(A1 A2 A3 A4) )
    end

    it 'should throw an error if the position list is the wrong size' do
      proc { Battleship.new( grid, %w(A1 A2 A3) ) }.must_raise RuntimeError
    end
  end

  describe '#type' do
    it 'should return its type' do
      Battleship.new( grid ).type.must_equal 'Battleship'
    end
  end
end

describe Cruiser do
  let( :grid ) { Grid.new :visible }

  describe '#initialize' do
    it 'should be initializable with a random position' do
      Cruiser.new( grid )
    end

    it 'should be initializable with a set of positions' do
      Cruiser.new( grid, %w(A1 A2 A3) )
    end

    it 'should throw an error if the position list is the wrong size' do
      proc { Cruiser.new( grid, %w(A1 A2 A3 A4) ) }.must_raise RuntimeError
    end
  end

  describe '#type' do
    it 'should return its type' do
      Cruiser.new( grid ).type.must_equal 'Cruiser'
    end
  end
end

describe Destroyer do
  let( :grid ) { Grid.new :visible }

  describe '#initialize' do
    it 'should be initializable with a random position' do
      Destroyer.new( grid )
    end

    it 'should be initializable with a set of positions' do
      Destroyer.new( grid, %w(A1 A2) )
    end

    it 'should throw an error if the position list is the wrong size' do
      proc { Destroyer.new( grid, %w(A1 A2 A3) ) }.must_raise RuntimeError
    end
  end

  describe '#type' do
    it 'should return its type' do
      Destroyer.new( grid ).type.must_equal 'Destroyer'
    end
  end
end

describe Submarine do
  let( :grid ) { Grid.new :visible }

  describe '#initialize' do
    it 'should be initializable with a random position' do
      Submarine.new( grid )
    end

    it 'should be initializable with a set of positions' do
      Submarine.new( grid, %w(A1) )
    end

    it 'should throw an error if the position list is the wrong size' do
      proc { Submarine.new( grid, %w(A1 A2) ) }.must_raise RuntimeError
    end
  end

  describe '#type' do
    it 'should return its type' do
      Submarine.new( grid ).type.must_equal 'Submarine'
    end
  end
end
