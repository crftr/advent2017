class KnotHash

  attr_accessor :list, :current_pos, :skip_size, :lengths

  def initialize(list_max, lengths = [], is_part2 = false)
    @list        = (0...list_max).to_a
    @current_pos = 0
    @skip_size   = 0
    @is_part2    = is_part2

    if @is_part2
      @lengths = KnotInputConverter.call(lengths)
    else
      @lengths = lengths
    end
  end

  def iterate
    reverse_selection

    move_current_position

    @skip_size += 1
    lengths.shift
  end

  def iterate_rounds(round_count = 1)
    lengths_copy = lengths

    round_count.times do
      lengths = lengths_copy
      iterate until lengths.count.eql?(0)
    end
  end

  def reverse_selection
    to_reverse = range_selection_to_reverse.to_a

    while to_reverse.count > 1
      front_idx = to_reverse.shift % list.length
      back_idx  = to_reverse.pop   % list.length

      temp = @list[back_idx]
      @list[back_idx]  = @list[front_idx]
      @list[front_idx] = temp
    end
  end

  def range_selection_to_reverse
    (current_pos...(current_pos + lengths[0]))
  end

  def move_current_position
    @current_pos += lengths[0] + skip_size
    @current_pos %= list.length
  end

  def increment_skip_size
    @skip_size += 1
  end
end

class KnotInputConverter
  def self.call args
    args =
      args.to_s
          .gsub(/\s/,'')[1..-2]
          .chars
          .map(&:ord)
          .join(',')

    "#{args},17,31,73,47,23".split(',').map(&:to_i)
  end
end


test = KnotHash.new(5, [3, 4, 1, 5])
test.iterate_rounds(1)
puts test.list[0] * test.list[1]

kh = KnotHash.new(256, [147,37,249,1,31,2,226,0,161,71,254,243,183,255,30,70])
kh.iterate_rounds(1)
puts kh.list[0] * kh.list[1]
