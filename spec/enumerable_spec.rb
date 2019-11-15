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

  
end
