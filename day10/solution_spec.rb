require 'rspec'
require './solution'

describe KnotHash do

  describe 'Part 1, example implementation' do

    before(:each) do
      @kh = KnotHash.new(5, [3, 4, 1, 5])
    end

    it 'will have the assumed default values' do
      expect(@kh.current_pos).to eql(0)
      expect(@kh.skip_size).to   eql(0)
      expect(@kh.list).to        eql([0, 1, 2, 3, 4])
      expect(@kh.lengths).to     eql([3, 4, 1, 5])
    end

    it 'will iterate, 1 time' do
      @kh.iterate
      expect(@kh.current_pos).to eql(3)
      expect(@kh.skip_size).to   eql(1)
      expect(@kh.list).to        eql([2, 1, 0, 3, 4])
      expect(@kh.lengths).to     eql([4, 1, 5])
    end

    it 'will iterate, 2 times' do
      @kh.iterate
      @kh.iterate
      expect(@kh.current_pos).to eql(3)
      expect(@kh.skip_size).to   eql(2)
      expect(@kh.list).to        eql([4, 3, 0, 1, 2])
      expect(@kh.lengths).to     eql([1, 5])
    end

    it 'will iterate, 3 times' do
      @kh.iterate
      @kh.iterate
      @kh.iterate
      expect(@kh.current_pos).to eql(1)
      expect(@kh.skip_size).to   eql(3)
      expect(@kh.list).to        eql([4, 3, 0, 1, 2])
      expect(@kh.lengths).to     eql([5])
    end

    it 'will iterate, 4 times' do
      @kh.iterate
      @kh.iterate
      @kh.iterate
      @kh.iterate
      expect(@kh.current_pos).to eql(4)
      expect(@kh.skip_size).to   eql(4)
      expect(@kh.list).to        eql([3, 4, 2, 1, 0])
      expect(@kh.lengths).to     eql([])
    end


  end
end
