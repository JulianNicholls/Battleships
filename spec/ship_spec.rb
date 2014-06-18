require 'minitest/autorun'
require 'minitest/pride'

require './grid'
require './shiptypes'

# Battleships module
module Battleships
  # Ship is not designed to be instantiated as itself

  describe Ship do
    let( :grid ) { Grid.new :visible }

    describe '#initialize' do
      it 'should be default initializable' do
        Ship.new( grid )
      end

      it 'should not be initializable on its own' do
        proc { Ship.new( grid, %w(A1 A2) ) }.must_raise RuntimeError
      end
    end

    describe 'Ship#sunk?' do
      it 'should return false if any part is not hit' do
        bs   = Battleship.new( grid )
        grid.add_ship( bs )
        most = bs.parts[1..-1]

        most.each do |pos|
          grid.attack( pos )
          bs.sunk?.must_equal false
        end
      end

      it 'should return true if all parts have been hit' do
        bs  = Battleship.new( grid )
        grid.add_ship( bs )

        bs.parts.each { |pos| grid.attack( pos ) }

        bs.sunk?.must_equal true
      end

      describe '#at?' do
        it 'should return false for a location that is not part of it' do
          poses = %w(A1 A2 A3 A4)
          bs    = Battleship.new( grid, poses )
          grid.add_ship( bs )

          bs.at?( 'A5' ).must_equal false
        end

        it 'should return true for a location that is part of it' do
          poses = %w(A1 A2 A3 A4)
          bs    = Battleship.new( grid, poses )
          grid.add_ship( bs )

          poses.each { |pos| bs.at?( pos ).must_equal true }
        end
      end
      
      describe '#swap_orientation' do
        it 'should swap from across to down' do
          bs = Battleship.new( grid, %w(A1 A2 A3 A4) )
          
          bs.swap_orientation
          bs.parts.must_equal %w(A1 B1 C1 D1)
        end

        it 'should swap from down to across' do
          bs = Battleship.new( grid, %w(A1 B1 C1 D1) )
          
          bs.swap_orientation
          bs.parts.must_equal %w(A1 A2 A3 A4)
        end
      end
    end
  end

  describe AircraftCarrier do
    let( :grid ) { Grid.new }

    describe '#initialize' do
      it 'should be initializable with no position' do
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

    describe '#piece_number' do
      it 'should return the correct numbers for a horizontal ship' do
        poses = %w(A1 A2 A3 A4 A5)
        ac    = AircraftCarrier.new( grid, poses)

        ac.piece_number( 'A1' ).must_equal 0
        ac.piece_number( 'A2' ).must_equal 1
        ac.piece_number( 'A3' ).must_equal 2
        ac.piece_number( 'A4' ).must_equal 3
        ac.piece_number( 'A5' ).must_equal 4
      end

      it 'should return the correct numbers for a vertical ship' do
        poses = %w(A1 B1 C1 D1 E1)
        ac    = AircraftCarrier.new( grid, poses)

        ac.piece_number( 'A1' ).must_equal 6
        ac.piece_number( 'B1' ).must_equal 7
        ac.piece_number( 'C1' ).must_equal 8
        ac.piece_number( 'D1' ).must_equal 9
        ac.piece_number( 'E1' ).must_equal 10
      end
    end
  end

  describe Battleship do
    let( :grid ) { Grid.new :visible }

    describe '#initialize' do
      it 'should be initializable with no position' do
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

    describe '#piece_number' do
      it 'should return the correct numbers for a horizontal ship' do
        poses = %w(A1 A2 A3 A4)
        ac    = Battleship.new( grid, poses)

        ac.piece_number( 'A1' ).must_equal 0
        ac.piece_number( 'A2' ).must_equal 1
        ac.piece_number( 'A3' ).must_equal 2
        ac.piece_number( 'A4' ).must_equal 4
      end

      it 'should return the correct numbers for a vertical ship' do
        poses = %w(B1 C1 D1 E1)
        ac    = Battleship.new( grid, poses)

        ac.piece_number( 'B1' ).must_equal 6
        ac.piece_number( 'C1' ).must_equal 7
        ac.piece_number( 'D1' ).must_equal 8
        ac.piece_number( 'E1' ).must_equal 10
      end
    end
  end

  describe Cruiser do
    let( :grid ) { Grid.new :visible }

    describe '#initialize' do
      it 'should be initializable with no position' do
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

    describe '#piece_number' do
      it 'should return the correct numbers for a horizontal ship' do
        poses = %w(A2 A3 A4)
        ac    = Cruiser.new( grid, poses)

        ac.piece_number( 'A2' ).must_equal 0
        ac.piece_number( 'A3' ).must_equal 2
        ac.piece_number( 'A4' ).must_equal 4
      end

      it 'should return the correct numbers for a vertical ship' do
        poses = %w(C1 D1 E1)
        ac    = Cruiser.new( grid, poses)

        ac.piece_number( 'C1' ).must_equal 6
        ac.piece_number( 'D1' ).must_equal 8
        ac.piece_number( 'E1' ).must_equal 10
      end
    end
  end

  describe Destroyer do
    let( :grid ) { Grid.new :visible }

    describe '#initialize' do
      it 'should be initializable with no position' do
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

    describe '#piece_number' do
      it 'should return the correct numbers for a horizontal ship' do
        poses = %w(A3 A4)
        ac    = Destroyer.new( grid, poses)

        ac.piece_number( 'A3' ).must_equal 0
        ac.piece_number( 'A4' ).must_equal 4
      end

      it 'should return the correct numbers for a vertical ship' do
        poses = %w(C1 D1)
        ac    = Destroyer.new( grid, poses)

        ac.piece_number( 'C1' ).must_equal 6
        ac.piece_number( 'D1' ).must_equal 10
      end
    end
  end

  describe Submarine do
    let( :grid ) { Grid.new :visible }

    describe '#initialize' do
      it 'should be initializable with no position' do
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

    describe '#piece_number' do
      it 'should return one of the two possibilities' do
        poses = %w(A3)
        ac    = Submarine.new( grid, poses)
        piece = ac.piece_number 'A3'

        piece.must_equal( piece == 5 ? 5 : 11 )
      end
    end
  end
end
