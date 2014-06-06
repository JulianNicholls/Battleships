require 'minitest/autorun'
require 'minitest/pride'

require './grid'

# testversion that is indexed row, column numerically
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

    it "should return a cell via ('D', 5)" do
      grid.cell_at( 'D', '5' ).state.must_equal :empty
    end

    it "should return a cell via ('d5') and ('d', 5)" do
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

  describe '#attack' do
    let( :grid ) { Grid.new }

    it 'should register a hit' do
      grid.set( 'D5' )
      grid.attack( 'D5' )

      grid.cell_at( 'D5' ).state.must_equal :hit
      grid.cell_at( 'D5' ).state_char.must_equal '*'
    end

    it 'should register a miss' do
      grid.attack( 'D5' )

      grid.cell_at( 'D5' ).state.must_equal :miss
      grid.cell_at( 'D5' ).state_char.must_equal 'X'
    end
  end

  describe '#Grid.next' do
    it 'should move to the next column' do
      Grid.next( 'G1', :across ).must_equal 'G2'
      Grid.next( 'G5', :across ).must_equal 'G6'
      Grid.next( 'G9', :across ).must_equal 'G10'
    end

    it 'should move to the next row' do
      Grid.next( 'A5', :down ).must_equal 'B5'
      Grid.next( 'D5', :down ).must_equal 'E5'
      Grid.next( 'I5', :down ).must_equal 'J5'
    end
  end

  describe '#Grid.prev' do
    it 'should move to the prev column' do
      Grid.prev( 'G2', :across ).must_equal 'G1'
      Grid.prev( 'G5', :across ).must_equal 'G4'
      Grid.prev( 'G10', :across ).must_equal 'G9'
    end

    it 'should move to the prev row' do
      Grid.prev( 'B5', :down ).must_equal 'A5'
      Grid.prev( 'D5', :down ).must_equal 'C5'
      Grid.prev( 'J5', :down ).must_equal 'I5'
    end
  end

  describe '#Grid.neighbours' do
    it 'should return the neigbours for a location' do
      Grid.neighbours( 'B5' ).must_equal %w(B4 B6 A5 C5)
    end
  end
end
