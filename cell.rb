class Cell
  attr_reader :state
  
  def initialize( state = :empty )
    @state = state
  end
  
  def attack
    return false if state == :empty || state == :hit
    
    @state = :hit
    true
  end
end
