require 'minitest/autorun'
require 'minitest/pride'

require './shiptypes'

# Ship is not designed to be instantiated

describe Ship do
  let( :grid ) { Grid.new :visible }

  describe '#initialise' do    
    it 'should be initializable with a random position' do
      bs = Ship.new( grid, nil, 5 )
    end
    
    it 'should be initializable with a set of positions' do
      bs = Ship.new( grid, ['A1', 'A2', 'A3', 'A4'], 4 )
    end

    it 'should throw an error if the position list is the wrong size' do
      proc { Ship.new( grid, ['A1', 'A2', 'A3', 'A4'], 3 ) }.must_raise RuntimeError
    end
  end
  
  describe '#name' do
    it 'should return its name' do
      Ship.new( grid, nil, 5 ).name.must_equal 'Ship'
    end
  end

  describe '#parts' do
    it 'should return the grid positions the ship occupies' do
      poses = ['A1', 'A2', 'A3', 'A4']
      
      bs = Battleship.new( grid, poses )
      bs.parts.must_equal poses
    end
  end  

  describe 'Ship#insert_into' do
    it 'should put the battleship into the grid somewhere' do
      bs = Battleship.new( grid )
      
      bs.parts.each { |pos| grid.cell_at( pos ).state.must_equal :occupied }
    end
  end
  
  describe 'Ship#sunk?' do
    it 'should return false if any part is not hit' do
      bs   = Battleship.new( grid )
      most = bs.parts[1..-1]
      
      most.each do |pos|
        grid.attack( pos )
        bs.sunk?.must_equal false
      end
    end

    it 'should not return true if any part is not hit' do
      bs  = Battleship.new( grid )
      
      bs.parts.each { |pos| grid.attack( pos ) }
  
      bs.sunk?.must_equal true
    end
  end
end

describe AircraftCarrier do
  let( :grid ) { Grid.new :visible }

  describe '#initialize' do
    it 'should be initializable with a random position' do
      bs = AircraftCarrier.new( grid )
    end

    it 'should be initializable with a set of positions' do
      bs = AircraftCarrier.new( grid, ['A1', 'A2', 'A3', 'A4', 'A5'] )
    end

    it 'should throw an error if the position list is the wrong size' do
      proc { AircraftCarrier.new( grid, ['A1', 'A2', 'A3'] ) }.must_raise RuntimeError
    end
  end
  
  describe '#name' do
    it 'should return its name' do
      AircraftCarrier.new( grid ).name.must_equal 'Aircraft Carrier'
    end
  end
end

describe Battleship do
  let( :grid ) { Grid.new :visible }

  describe '#initialize' do
    it 'should be initializable with a random position' do
      bs = Battleship.new( grid )
    end

    it 'should be initializable with a set of positions' do
      bs = Battleship.new( grid, ['A1', 'A2', 'A3', 'A4'] )
    end

    it 'should throw an error if the position list is the wrong size' do
      proc { Battleship.new( grid, ['A1', 'A2', 'A3'] ) }.must_raise RuntimeError
    end
  end
  
  describe '#name' do
    it 'should return its name' do
      Battleship.new( grid ).name.must_equal 'Battleship'
    end
  end
end

describe Cruiser do
  let( :grid ) { Grid.new :visible }

  describe '#initialize' do
    it 'should be initializable with a random position' do
      bs = Cruiser.new( grid )
    end

    it 'should be initializable with a set of positions' do
      bs = Cruiser.new( grid, ['A1', 'A2', 'A3'] )
    end

    it 'should throw an error if the position list is the wrong size' do
      proc { Cruiser.new( grid, ['A1', 'A2', 'A3', 'A4'] ) }.must_raise RuntimeError
    end
  end
  
  describe '#name' do
    it 'should return its name' do
      Cruiser.new( grid ).name.must_equal 'Cruiser'
    end
  end
end

describe Destroyer do
  let( :grid ) { Grid.new :visible }

  describe '#initialize' do
    it 'should be initializable with a random position' do
      bs = Destroyer.new( grid )
    end

    it 'should be initializable with a set of positions' do
      bs = Destroyer.new( grid, ['A1', 'A2'] )
    end

    it 'should throw an error if the position list is the wrong size' do
      proc { Destroyer.new( grid, ['A1', 'A2', 'A3'] ) }.must_raise RuntimeError
    end
  end
  
  describe '#name' do
    it 'should return its name' do
      Destroyer.new( grid ).name.must_equal 'Destroyer'
    end
  end
end

describe Submarine do
  let( :grid ) { Grid.new :visible }

  describe '#initialize' do
    it 'should be initializable with a random position' do
      bs = Submarine.new( grid )
    end

    it 'should be initializable with a set of positions' do
      bs = Submarine.new( grid, ['A1'] )
    end

    it 'should throw an error if the position list is the wrong size' do
      proc { Submarine.new( grid, ['A1', 'A2'] ) }.must_raise RuntimeError
    end
  end
  
  describe '#name' do
    it 'should return its name' do
      Submarine.new( grid ).name.must_equal 'Submarine'
    end
  end
end
