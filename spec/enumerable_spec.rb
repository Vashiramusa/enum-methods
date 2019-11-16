# frozen_string_literal: true

require_relative '../enumerable_methods.rb'
describe Enumerable do
  let(:arr) { [3, 11, 8, 9, 1, 12, 3, 5, 2, 4, 6] }
  let(:empt_arr) { [] }
  let(:my_string) { %w[v a s h i r a] }

  describe '#my_each' do
    context 'if block is not given' do
      it 'returns enumerable object' do
        expect(arr.my_each.is_a?(Enumerable)).to eql(true)
      end
    end

    context 'if block is given' do
      it 'iterates through array of elements' do
        real_arr = []
        arr.my_each { |i| empt_arr << i }
        arr.each { |i| real_arr << i }
        expect(empt_arr).to eql(real_arr)
      end
    end
  end

  describe '#my_each_with_index' do
    context 'if block is not given' do
      it 'returns enumerable object' do
        expect(arr.my_each_with_index.is_a?(Enumerable)).to eql(true)
      end
    end
    context 'if block is given' do
      it 'it iterates through the collection and yields the element and the corresponding index' do
        my_string.my_each_with_index { |_element, index| empt_arr << index }
        expect(empt_arr).to eql([0, 1, 2, 3, 4, 5, 6])
      end
    end
  end

  describe '#my_select' do
    context 'if block is not given' do
      it 'returns enumerable object' do
        expect(arr.my_select.is_a?(Enumerable)).to eql(true)
      end
    end
    context 'if block is given' do
      it 'returns selected values in an array based on the given block' do
        expect(arr.my_select(&:even?)).to eql([8, 12, 2, 4, 6])
      end
    end
  end

  describe '#my_count' do
    context 'If block is not given' do
      it 'Return enumerable object' do
        expect(arr.my_count.is_a?(Enumerable)).to eql(false)
      end
    end

    context 'If block is given' do
      it 'returns array length' do
        expect(arr.my_count).to eq(11)
      end
    end
  end

  describe '#my_map' do
    context 'If block is not given' do
      it 'Return enumerable object' do
        expect(arr.my_map.is_a?(Enumerable)).to eql(true)
      end
    end
    context 'If block is given' do
      it 'returns a new array with the results of running through the block once on a given array' do
        answer = arr.my_map { |i| i**3 }
        expect(answer).to eql(arr.map { |i| i**3 })
      end
    end
  end

  describe '#my_all?' do
    context 'If block is not given' do
      it 'Return enumerable object' do
        expect(arr.my_all?.is_a?(Enumerable)).to eql(false)
      end
    end

    context 'when passed block with condition met' do
      it 'returns true' do
        expect(arr.my_all? { |num| num < 15 }).to eql(true)
      end
    end
  end

  describe '#my_any?' do
    context 'If block is not given' do
      it 'Return enumerable object' do
        expect(arr.my_any?.is_a?(Enumerable)).to eql(false)
      end
    end

    context 'when passed block with condition met' do
      it 'returns true' do
        expect(arr.my_any?([5, 'dog', 50])).to eql(false)
      end
    end
  end
end
