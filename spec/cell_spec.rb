require 'minitest/autorun'
require 'minitest/pride'

require './cell'

describe Cell do
  describe '#initialize' do
    it 'should be initializable empty and invisible by default' do
      cell = Cell.new
      cell.state.must_equal :empty
      cell.empty?.must_equal true
      cell.visible.must_equal false
    end

    it 'should be initializable empty and invisible by choice' do
      cell = Cell.new :empty, false
      cell.state.must_equal :empty
      cell.empty?.must_equal true
      cell.visible.must_equal false
    end

    it 'should be initializable empty and visible' do
      cell = Cell.new( :empty, :visible )
      cell.state.must_equal :empty
      cell.empty?.must_equal true
      cell.visible.wont_equal false
    end

    it 'should be initializable occupied and invisible' do
      cell = Cell.new :occupied
      cell.state.must_equal :occupied
      cell.empty?.must_equal false
      cell.visible.must_equal false
    end

    it 'should be initializable occupied and visible' do
      cell = Cell.new( :occupied, true )
      cell.state.must_equal :occupied
      cell.empty?.must_equal false
      cell.visible.wont_equal false
    end
  end

  describe '#state' do
    it 'should return empty state correctly' do
      cell = Cell.new
      cell.state.must_equal :empty
    end

    it 'should return occupied state correctly' do
      cell = Cell.new :occupied
      cell.state.must_equal :occupied
    end

    it 'should return hit state correctly' do
      cell = Cell.new :occupied
      cell.attack
      cell.state.must_equal :hit
    end

    it 'should return miss state correctly' do
      cell = Cell.new
      cell.attack
      cell.state.must_equal :miss
    end
  end

  describe '#attack' do
    it 'should return true for an attacked occupied square' do
      cell = Cell.new :occupied
      cell.attack.must_equal true
    end

    it 'should change the state and visibilty for an attacked occupied square' do
      cell = Cell.new :occupied
      cell.attack
      cell.state.must_equal :hit
      cell.visible.must_equal true
    end

    it 'should return false for an attacked empty square' do
      cell = Cell.new
      cell.empty?.must_equal true
      cell.attack.must_equal false
      cell.state.must_equal :miss
      cell.empty?.must_equal true
    end

    it 'should return false for an already attacked square' do
      cell = Cell.new :occupied
      cell.attack
      cell.attack.must_equal false
      cell.state.must_equal :hit
    end
  end

  describe '#state_char' do
    it "should always return ' ' if the cell isn't visible" do
      empty = Cell.new
      empty.state_char.must_equal ' '

      occ = Cell.new :occupied
      occ.state_char.must_equal ' '

      occ.attack
      occ.state_char.wont_equal ' '   # Always visible once attacked
      occ.state_char.must_equal '*'
    end

    it "should return '+' for occupied and visible" do
      occ = Cell.new( :occupied, :visible )
      occ.state_char.must_equal '+'
    end

    it "should return 'X' for miss" do
      occ = Cell.new( :empty )
      occ.attack
      occ.state_char.must_equal 'X'
    end

    it "should return '*' for hit" do
      occ = Cell.new( :occupied )
      occ.attack
      occ.state_char.must_equal '*'
    end
  end

  describe '#set' do
    it 'should go from empty to occupied' do
      cell = Cell.new
      cell.state.must_equal :empty
      cell.set
      cell.state.must_equal :occupied
    end
  end
end
