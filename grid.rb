require './cell'

class Grid
  def initialize( width = 10, height = 10 )
    @width, @height = width, height
    @grid = empty_grid( width, height )
  end
  
  def cell_at( letter, number = nil )
    letter.upcase!
    
    if letter.size > 1
      row = letter[0].ord - 'A'.ord
      col = letter[1..-1].to_i - 1
    else
      row = letter.ord - 'A'.ord
      col = number - 1
    end

    @grid[row * @width + col]
  end

  private
  
  def empty_grid( width, height )
    Array.new( width * height ) { Cell.new }
  end
end