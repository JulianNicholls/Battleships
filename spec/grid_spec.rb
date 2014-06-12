require 'minitest/autorun'
require 'minitest/pride'

require './grid'
require './ship'

# Battleships module
module Battleships
  # test version that is indexed row, column numerically
  class Grid
    def cell_at_set( row, col )
      @grid[row * @width + col].set
    end
  end

  describe Grid do
    describe '#initialize' do
      it 'should be initializable' do
        Grid.new
      end
    end

    describe '#cell_at parsing' do
      let( :grid ) { Grid.new }

      it "should return a cell via ('D5')" do
        grid.cell_at( 'D5' ).state.must_equal :empty
      end

      it "should return a cell via ('D', '5')" do
        grid.cell_at( 'D', '5' ).state.must_equal :empty
      end

      it "should return a cell via ('d5') and ('d', '5')" do
        grid.cell_at( 'd5' ).state.must_equal :empty
        grid.cell_at( 'd', '5' ).state.must_equal :empty
      end
    end

    describe '#cell_at location' do
      let( :grid ) { Grid.new }

      it 'should return A1 correctly' do
        grid.cell_at_set( 0, 0 )
        grid.cell_at( 'A1' ).state.must_equal :occupied
        grid.cell_at( 'A', '1' ).state.must_equal :occupied
      end

      it 'should return A10 correctly' do
        grid.cell_at_set( 0, 9 )
        grid.cell_at( 'A10' ).state.must_equal :occupied
        grid.cell_at( 'A', '10' ).state.must_equal :occupied
      end

      it 'should return J1 correctly' do
        grid.cell_at_set( 9, 0 )
        grid.cell_at( 'J1' ).state.must_equal :occupied
        grid.cell_at( 'J', '1' ).state.must_equal :occupied
      end

      it 'should return J10 correctly' do
        grid.cell_at_set( 9, 9 )
        grid.cell_at( 'J10' ).state.must_equal :occupied
        grid.cell_at( 'J', '10' ).state.must_equal :occupied
      end

      it 'should return E/F 5/6 correctly' do
        grid.cell_at_set( 4, 4 )
        grid.cell_at( 'E5' ).state.must_equal :occupied
        grid.cell_at( 'E6' ).state.must_equal :empty
        grid.cell_at( 'F5' ).state.must_equal :empty
        grid.cell_at( 'F6' ).state.must_equal :empty

        grid.cell_at_set( 4, 5 )
        grid.cell_at( 'E6' ).state.must_equal :occupied
        grid.cell_at( 'F5' ).state.must_equal :empty
        grid.cell_at( 'F6' ).state.must_equal :empty

        grid.cell_at_set( 5, 4 )
        grid.cell_at( 'F5' ).state.must_equal :occupied
        grid.cell_at( 'F6' ).state.must_equal :empty

        grid.cell_at_set( 5, 5 )
        grid.cell_at( 'F6' ).state.must_equal :occupied
      end
    end

    describe '#set' do
      it 'should set a cell to occupied' do
        grid = Grid.new
        grid.set( 'D5' )
        grid.cell_at( 'D5' ).state.must_equal :occupied
      end
    end

    describe '#ships' do
      it 'should initially return an empty list of inserted ships' do
        grid  = Grid.new
        grid.ships.must_be_instance_of Array
        grid.ships.must_be_empty
      end

      it 'should return a list of 1 inserted ships' do
        grid  = Grid.new
        grid.add_ship( Battleship.new( grid ) )
        grid.ships.must_be_instance_of Array
        grid.ships.size.must_equal 1
      end

      it 'should return a list of more inserted ships' do
        grid  = Grid.new
        grid.add_ship( Battleship.new( grid ) )
        grid.add_ship( Cruiser.new( grid ) )
        grid.ships.must_be_instance_of Array
        grid.ships.size.must_equal 2

        grid.add_ship( AircraftCarrier.new( grid ) )
        grid.ships.size.must_equal 3
      end
    end

    describe '#add_ship' do
      it 'should allow adding a fully-specified ship' do
        grid  = Grid.new
        poses = %w(A1 A2 A3 A4)
        grid.add_ship( Battleship.new( grid, poses ) )

        poses.each { |pos| grid.cell_at( pos ).state.must_equal :occupied }
      end

      it 'should be able to insert a ship randomly and separately' do
        grid  = Grid.new
        bs    = Battleship.new( grid )
        grid.add_ship( bs )

        bs.parts.wont_be_empty
        grid.ships.first.parts.wont_be_empty
        grid.ships.first.parts.each do |pos|
          grid.cell_at( pos ).state.must_equal :occupied
        end
      end
    end

    describe '#attack' do
      let( :grid ) { Grid.new }

      it 'should register a hit' do
        grid.set( 'D5' )
        grid.attack( 'D5' )

        grid.cell_at( 'D5' ).state.must_equal :hit
        grid.cell_at( 'D5' ).shape.must_match( /\*/ )
      end

      it 'should register a miss' do
        grid.attack( 'D5' )

        grid.cell_at( 'D5' ).state.must_equal :miss
        grid.cell_at( 'D5' ).shape.must_match( /X/ )
      end
    end
  end
end
