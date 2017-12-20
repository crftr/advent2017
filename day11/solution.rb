class HexEd
  def initialize(moves)
    @pos = HexPosition.new
    @moves = moves

    process_moves
  end

  def process_moves
    @moves.each { |m| @pos.move(m) }
  end

  def distance
    @pos.distance_to(0,0,0)
  end
end

class HexPosition
  def initialize
    @x = 0
    @y = 0
    @z = 0
  end

  def distance_to(x, y, z)
    (
      (@x - x).abs +
      (@y - y).abs +
      (@z - z).abs
    ) / 2
  end

  def move(direction)
    case direction
    when 'nw'
      @x -= 1
      @y += 1
    when 'n'
      @y += 1
      @z -= 1
    when 'ne'
      @x += 1
      @z -= 1
    when 'se'
      @x += 1
      @y -= 1
    when 's'
      @y -= 1
      @z += 1
    when 'sw'
      @x -= 1
      @z += 1
    else
      raise "bugger!"
    end
  end
end

File.open('input.txt', 'r') do |f|
  f.each_line do |line|
    input = line.split(',').map(&:strip)

    h1 = HexEd.new(input)

    puts "Part 1"
    puts "Steps: #{h1.distance}"
  end
end

