require 'minitest/autorun'
require 'minitest/pride'

require './grid'
require './shiptypes'

# Ship is not designed to be instantiated as itself

module Battleships
  describe Ship do
    let( :grid ) { Grid.new :visible }

    describe '#initialize' do
      it 'should not be initializable on its own' do
#        proc { Ship.new( grid ) }.must_raise RuntimeError
        proc { Ship.new( grid, %w(A1 A2) ) }.must_raise RuntimeError
      end
    end

  #  describe 'Ship#insert_into' do
  #    it 'should put the ship into the grid somewhere' do
  #      bs = Ship.new( grid, nil, 4 )
  #
  #      bs.parts.each { |pos| grid.cell_at( pos ).state.must_equal :occupied }
  #    end
  #  end

    describe 'Ship#sunk?' do
      it 'should return false if any part is not hit' do
        bs   = Battleship.new( grid )
        most = bs.parts[1..-1]
  
        most.each do |pos|
          grid.attack( pos )
          bs.sunk?.must_equal false
        end
      end
  
      it 'should return true if all parts have been hit' do
        bs  = Battleship.new( grid )
  
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
        proc do
          AircraftCarrier.new( grid, %w(A1 A2 A3 A4) )
        end.must_raise RuntimeError
      end
    end

    describe '#type' do
      it 'should return its type' do
        AircraftCarrier.new( grid ).type.must_equal 'Aircraft Carrier'
      end
    end
  
    describe '#length' do
      it 'should return 5' do
        AircraftCarrier.new( grid ).length.must_equal 5
      end
    end

    describe '#parts' do
      it 'should return the grid positions the ship occupies' do
        poses = %w(A1 A2 A3 A4 A5)

        bs = AircraftCarrier.new( grid, poses )
        bs.parts.must_equal poses
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
        proc do
          Battleship.new( grid, %w(A1 A2 A3) )
        end.must_raise RuntimeError
      end
    end

    describe '#type' do
      it 'should return its type' do
        Battleship.new( grid ).type.must_equal 'Battleship'
      end
    end
  
    describe '#length' do
      it 'should return 4' do
        Battleship.new( grid ).length.must_equal 4
      end
    end

    describe '#parts' do
      it 'should return the grid positions the ship occupies' do
        poses = %w(A1 A2 A3 A4)

        bs = Battleship.new( grid, poses )
        bs.parts.must_equal poses
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
        proc do
          Cruiser.new( grid, %w(A1 A2 A3 A4) )
        end.must_raise RuntimeError
      end
    end

    describe '#type' do
      it 'should return its type' do
        Cruiser.new( grid ).type.must_equal 'Cruiser'
      end
    end
  
    describe '#length' do
      it 'should return 3' do
        Cruiser.new( grid ).length.must_equal 3
      end
    end

    describe '#parts' do
      it 'should return the grid positions the ship occupies' do
        poses = %w(A2 A3 A4)

        bs = Cruiser.new( grid, poses )
        bs.parts.must_equal poses
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
        proc do
          Destroyer.new( grid, %w(A1 A2 A3) )
        end.must_raise RuntimeError
      end
    end

    describe '#type' do
      it 'should return its type' do
        Destroyer.new( grid ).type.must_equal 'Destroyer'
      end
    end
  
    describe '#length' do
      it 'should return 2' do
        Destroyer.new( grid ).length.must_equal 2
      end
    end

    describe '#parts' do
      it 'should return the grid positions the ship occupies' do
        poses = %w(A2 A3)

        bs = Destroyer.new( grid, poses )
        bs.parts.must_equal poses
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
  
    describe '#length' do
      it 'should return 1' do
        Submarine.new( grid ).length.must_equal 1
      end
    end

    describe '#parts' do
      it 'should return the grid position the ship occupies' do
        poses = %w(A2)

        bs = Submarine.new( grid, poses )
        bs.parts.must_equal poses
      end
    end
  end
end
