require 'minitest/autorun'
require 'minitest/pride'

require './cell'

describe Cell do
  describe '#initialize' do
    it "should be initializable empty by default" do
      cell = Cell.new
      cell.state.must_equal :empty
    end

    it "should be initializable empty by choice" do
      cell = Cell.new :empty
      cell.state.must_equal :empty
    end

    it "should be initializable occupied" do
      cell = Cell.new :occupied
      cell.state.must_equal :occupied
    end
  end
  
  describe '#attack' do
    it "should return true for an attacked occupied square" do
      cell = Cell.new :occupied
      cell.attack.must_equal true
    end

    it "should change the state for an attacked occupied square" do
      cell = Cell.new :occupied
      cell.attack
      cell.state.must_equal :hit
    end

    it "should return false for an attacked empty square" do
      cell = Cell.new
      cell.attack.must_equal false
    end

    it "should return false for an already attacked square" do
      cell = Cell.new :occupied
      cell.attack
      cell.attack.must_equal false
    end
  end
end
