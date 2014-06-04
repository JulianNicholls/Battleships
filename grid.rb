require './cell'

class Grid
  def initialize( visible = false, width = 10, height = 10 )
    @width, @height = width, height
    @grid = empty_grid( width, height, visible )
  end
  
  def cell_at( letter, number = nil )
    letter.upcase!
    
    if letter.size > 1
      row = letter[0].ord - 'A'.ord
      col = letter[1..-1].to_i - 1
    else
      row = letter.ord - 'A'.ord
      col = number.to_i - 1
    end

    @grid[row * @width + col]
  end
  
  def to_s( headers = false )
    str = ''
    
    if headers
      str << "  "
      (1..10).each { |n| str << "#{n} " } if headers
      str << "\n" 
    end
    
    ('A'..'J').each do |letter|
      str << "#{letter} " if headers
      
      (1..10).each do |col|
        str << "#{cell_at( letter, col ).state_char} "
      end

      str << "\n"
    end
    
    str
  end

  def set( row, col = nil )
    cell_at( row, col ).set
  end
  
  def attack( row, col = nil )
    cell_at( row, col ).attack    
  end
  
  def show
    @grid.map( &:show )
  end
  
  private
  
  def empty_grid( width, height, visible )
    Array.new( width * height ) { Cell.new( :empty, visible ) }
  end
end
