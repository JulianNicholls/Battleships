require 'minitest/autorun'
require 'minitest/pride'

require './shiptypes'

# Ship is not designed to be instantiated as itself

describe Battleships::Ship do
  let( :grid ) { Battleships::Grid.new :visible }

  describe '#initialize' do
    it 'should be initializable with a random position' do
      Battleships::Ship.new( grid, nil, 5 )
    end

    it 'should be initializable with a set of positions' do
      Battleships::Ship.new( grid, %w(A1 A2 A3 A4), 4 )
    end

    it 'should throw an error if the position list is the wrong size' do
      proc { Battleships::Ship.new( grid, %w(A1 A2 A3 A4), 3 ) }.must_raise RuntimeError
    end
  end

  describe '#type' do
    it 'should return its type' do
      Battleships::Ship.new( grid, nil, 5 ).type.must_equal 'Ship'
    end
  end

  describe '#parts' do
    it 'should return the grid positions the ship occupies' do
      poses = %w(A1 A2 A3 A4)

      bs = Battleships::Ship.new( grid, poses, 4 )
      bs.parts.must_equal poses
    end
  end

  describe 'Ship#insert_into' do
    it 'should put the ship into the grid somewhere' do
      bs = Battleships::Ship.new( grid, nil, 4 )

      bs.parts.each { |pos| grid.cell_at( pos ).state.must_equal :occupied }
    end
  end

  describe 'Ship#sunk?' do
    it 'should return false if any part is not hit' do
      bs   = Battleships::Ship.new( grid, nil, 4 )
      most = bs.parts[1..-1]

      most.each do |pos|
        grid.attack( pos )
        bs.sunk?.must_equal false
      end
    end

    it 'should not return true if any part is not hit' do
      bs  = Battleships::Ship.new( grid, nil, 4 )

      bs.parts.each { |pos| grid.attack( pos ) }

      bs.sunk?.must_equal true
    end
  end
end

describe Battleships::AircraftCarrier do
  let( :grid ) { Battleships::Grid.new }

  describe '#initialize' do
    it 'should be initializable with a random position' do
      Battleships::AircraftCarrier.new( grid )
    end

    it 'should be initializable with a set of positions' do
      Battleships::AircraftCarrier.new( grid, %w(A1 A2 A3 A4 A5) )
    end

    it 'should throw an error if the position list is the wrong size' do
      proc { Battleships::AircraftCarrier.new( grid, %w(A1 A2 A3 A4) ) }.must_raise RuntimeError
    end
  end

  describe '#type' do
    it 'should return its type' do
      Battleships::AircraftCarrier.new( grid ).type.must_equal 'Aircraft Carrier'
    end
  end
end

describe Battleships::Battleship do
  let( :grid ) { Battleships::Grid.new :visible }

  describe '#initialize' do
    it 'should be initializable with a random position' do
      Battleships::Battleship.new( grid )
    end

    it 'should be initializable with a set of positions' do
      Battleships::Battleship.new( grid, %w(A1 A2 A3 A4) )
    end

    it 'should throw an error if the position list is the wrong size' do
      proc { Battleships::Battleship.new( grid, %w(A1 A2 A3) ) }.must_raise RuntimeError
    end
  end

  describe '#type' do
    it 'should return its type' do
      Battleships::Battleship.new( grid ).type.must_equal 'Battleship'
    end
  end
end

describe Battleships::Cruiser do
  let( :grid ) { Battleships::Grid.new :visible }

  describe '#initialize' do
    it 'should be initializable with a random position' do
      Battleships::Cruiser.new( grid )
    end

    it 'should be initializable with a set of positions' do
      Battleships::Cruiser.new( grid, %w(A1 A2 A3) )
    end

    it 'should throw an error if the position list is the wrong size' do
      proc { Battleships::Cruiser.new( grid, %w(A1 A2 A3 A4) ) }.must_raise RuntimeError
    end
  end

  describe '#type' do
    it 'should return its type' do
      Battleships::Cruiser.new( grid ).type.must_equal 'Cruiser'
    end
  end
end

describe Battleships::Destroyer do
  let( :grid ) { Battleships::Grid.new :visible }

  describe '#initialize' do
    it 'should be initializable with a random position' do
      Battleships::Destroyer.new( grid )
    end

    it 'should be initializable with a set of positions' do
      Battleships::Destroyer.new( grid, %w(A1 A2) )
    end

    it 'should throw an error if the position list is the wrong size' do
      proc { Battleships::Destroyer.new( grid, %w(A1 A2 A3) ) }.must_raise RuntimeError
    end
  end

  describe '#type' do
    it 'should return its type' do
      Battleships::Destroyer.new( grid ).type.must_equal 'Destroyer'
    end
  end
end

describe Battleships::Submarine do
  let( :grid ) { Battleships::Grid.new :visible }

  describe '#initialize' do
    it 'should be initializable with a random position' do
      Battleships::Submarine.new( grid )
    end

    it 'should be initializable with a set of positions' do
      Battleships::Submarine.new( grid, %w(A1) )
    end

    it 'should throw an error if the position list is the wrong size' do
      proc { Battleships::Submarine.new( grid, %w(A1 A2) ) }.must_raise RuntimeError
    end
  end

  describe '#type' do
    it 'should return its type' do
      Battleships::Submarine.new( grid ).type.must_equal 'Submarine'
    end
  end
end
