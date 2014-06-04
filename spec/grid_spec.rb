require 'minitest/autorun'
require 'minitest/pride'

require './grid'

describe Grid do
  describe '#initialize' do
    it "should be initializable" do
      grid = Grid.new
    end
  end
  
  describe '#cell_at' do
    let( :grid ) { Grid.new }
    
    it "should return a cell via ('D5')" do
      grid.cell_at( 'D5' ).state.must_equal :empty
    end

    it "should return a cell via ('D', 5)" do
      grid.cell_at( 'D', 5 ).state.must_equal :empty
    end

    it "should return a cell via ('d', 5) and ('d5')" do
      grid.cell_at( 'd5' ).state.must_equal :empty
      grid.cell_at( 'd', 5 ).state.must_equal :empty
    end
  end
end