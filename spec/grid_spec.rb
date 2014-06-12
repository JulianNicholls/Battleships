require 'minitest/autorun'
require 'minitest/pride'

require './grid'
require './ship'

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
        grid.ships.first.parts.each{ |pos| grid.cell_at( pos ).state.must_equal :occupied }
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

    describe 'Grid.next' do
      it 'should move to the next column in the middle' do
        Grid.next( 'G1', :across ).must_equal 'G2'
        Grid.next( 'G5', :across ).must_equal 'G6'
        Grid.next( 'G9', :across ).must_equal 'G10'
      end

      it 'should move to the next row in the middle' do
        Grid.next( 'A5', :down ).must_equal 'B5'
        Grid.next( 'D5', :down ).must_equal 'E5'
        Grid.next( 'I5', :down ).must_equal 'J5'
      end

      it 'should accept lower-case' do
        Grid.next( 'g9', :across ).must_equal 'G10'
        Grid.next( 'i5', :down ).must_equal 'J5'
      end

      it 'should return nil if there is no next' do
        Grid.next( 'G10', :across ).must_be_nil
        Grid.next( 'J3', :down ).must_be_nil
      end

      it 'should reject bad locations' do
        Grid.next( 'A11', :down ).must_be_nil
        Grid.next( 'A0', :down ).must_be_nil
        Grid.next( 'K1', :across ).must_be_nil
      end
    end

    describe 'Grid.prev' do
      it 'should move to the prev column in the middle' do
        Grid.prev( 'G2', :across ).must_equal 'G1'
        Grid.prev( 'G5', :across ).must_equal 'G4'
        Grid.prev( 'G10', :across ).must_equal 'G9'
      end

      it 'should move to the prev row in the middle' do
        Grid.prev( 'B5', :down ).must_equal 'A5'
        Grid.prev( 'D5', :down ).must_equal 'C5'
        Grid.prev( 'J5', :down ).must_equal 'I5'
      end

      it 'should accept lower-case' do
        Grid.prev( 'g10', :across ).must_equal 'G9'
        Grid.prev( 'j5', :down ).must_equal 'I5'
      end

      it 'should return nil if there is no prev' do
        Grid.prev( 'G1', :across ).must_be_nil
        Grid.prev( 'A3', :down ).must_be_nil
      end

      it 'should reject bad locations' do
        Grid.prev( 'A11', :down ).must_be_nil
        Grid.prev( 'A0', :down ).must_be_nil
        Grid.prev( 'K1', :across ).must_be_nil
      end
    end

    describe '#Grid.neighbours' do
      it 'should return all four neighbours for a middle location' do
        Grid.neighbours( 'B5' ).must_equal %w(B4 B6 A5 C5)
      end

      it 'should return three neighbours for a top location' do
        Grid.neighbours( 'A5' ).must_equal %w(A4 A6 B5)
      end

      it 'should return three neighbours for a left location' do
        Grid.neighbours( 'B1' ).must_equal %w(B2 A1 C1)
      end

      it 'should return three neighbours for a right location' do
        Grid.neighbours( 'B10' ).must_equal %w(B9 A10 C10)
      end

      it 'should return three neighbours for a bottom location' do
        Grid.neighbours( 'J5' ).must_equal %w(J4 J6 I5)
      end

      it 'should return just two neighbours for a corner location' do
        Grid.neighbours( 'A1' ).must_equal %w(A2 B1)
        Grid.neighbours( 'A10' ).must_equal %w(A9 B10)
        Grid.neighbours( 'J1' ).must_equal %w(J2 I1)
        Grid.neighbours( 'J10' ).must_equal %w(J9 I10)
      end
    end
  end
end
