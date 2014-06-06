# Generic Ship
class Ship
  ROWS = 'ABCDEFGHIJ'
  
  attr_reader :parts

  def initialize( grid, positions = nil, length = 0 )
    fail "Position list wrong length #{positions.length}, should be #{length}" \
      unless positions.nil? || positions.size == length

    @grid  = grid
    @parts = positions || insert_into_grid( length )
  end

  def name
    self.class.to_s
  end

  def insert_into_grid( length )
    fail 'Cannot insert a zero-length ship' if length == 0
    poses = []

    loop do
      dir, cur = random_start_point( length )
      poses = try( length, cur, dir )
      break unless poses.nil?
    end

    poses.each { |pos| @grid.cell_at( pos ).set }
    poses
  end

  def sunk?
    parts.all? { |pos| @grid.cell_at( pos ).state == :hit }
  end

  private

  def random_start_point( length )
    dir = [:across, :down][rand 2]

    if dir == :across
      cur = ROWS[rand 10] + rand( 1..(11 - length) ).to_s
    else
      cur = ROWS[rand( 10 - length )] + rand( 1..10 ).to_s
    end

    [dir, cur]
  end

  def try( length, cur, dir )
    poses = []

    loop do
      break unless isolated?( cur )

      poses << cur
      return poses if poses.size == length
      cur = Grid.next( cur, dir )
    end

    nil
  end

  def isolated?( pos )
    return false unless @grid.cell_at( pos ).empty?

    Grid.neighbours( pos ).all? { |loc| @grid.cell_at( loc ).empty? }
  end
end
