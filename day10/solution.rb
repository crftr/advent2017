class KnotHash

  attr_accessor :list, :current_pos, :skip_size, :lengths

  def initialize(list_max: 255, lengths: [])
    @list        = (0...list_max).to_a
    @current_pos = 0
    @skip_size   = 0

    @lengths = lengths
  end

  def iterate
    reverse_selection

    move_current_position

    @skip_size += 1
    lengths.shift
  end

  def iterate_until_all_lengths_exausted
    iterate until lengths.count.eql?(0)
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


test = KnotHash.new(list_max: 5, lengths: [3, 4, 1, 5])
test.iterate_until_all_lengths_exausted
puts test.list[0] * test.list[1]

kh = KnotHash.new(list_max: 256, lengths: [147,37,249,1,31,2,226,0,161,71,254,243,183,255,30,70])
kh.iterate_until_all_lengths_exausted
puts kh.list[0] * kh.list[1]
