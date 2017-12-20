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
  end
end

class HexPosition
  def initialize
    @x = 0
    @y = 0
  end

  def move(direction)
    y_change, x_change = direction.chars.to_a

    case y_change
    when 'n'
      @y += 1
    when 's'
      @y -= 1
    end

    return if x_change.nil?

    case x_change
    when 'e'
      @x += 1
    when 'w'
      @x -= 1
    end
  end
end
