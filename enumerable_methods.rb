# frozen_string_literal: true

module Enumerable
  def my_each
    return to_enum unless block_given?

    i = 0
    while i < size
      yield(self[i])
      i += 1
    end
  end

  def my_each_with_index
    return to_enum unless block_given?

    size.times do |i|
      yield(self[i], i)
    end
    self
  end

  def my_select
    return to_enum unless block_given?

    selected = []
    my_each do |element|
      result = yield(element)
      selected << element if result
    end
    selected
  end

  def my_all?
    my_each do |i|
      if block_given?
        return false unless yield(i)
      else
        return false unless i
      end
    end
    true
  end

  def my_any?
    my_each do |i|
      if block_given?
        return true if yield(i)
      else
        return true until i
      end
    end
    false
  end

  def my_none?
    my_each do |i|
      if block_given?
        return false if yield(i)
      else
        return true until i
      end
    end
    true
  end
end

# test = [1, 4, 6, 7]
# test.each do |x|
#   puts x
# end

# test.my_each do |i|
#   puts i
# end

# my_test = [11, 4, 5, 7, 8]
# my_test.each do |t, y|
#   puts " #{t} #{y} "
# end

# my_test.each_with_index do |s, l|
#   puts "#{s} #{l}"
# end
# my_test.my_each_with_index do |i, k|
#   puts " #{i} #{k} "
# end

# puts [1, 2, 3, 4, 5].select(&:even?) #=> [2, 4]

# puts [1, 2, 3, 4, 5].my_select(&:even?) #=> [2, 4]

# puts %w[ant bear cat].all? { |word| word.length >= 3 } #=> true
# puts %w[ant bear cat].all? { |word| word.length >= 4 } #=> false
# puts %w[ant bear cat].all?(/t/) #=> false
# puts [1, 2i, 3.14].all?(Numeric) #=> true
# puts [nil, true, 99].all? #=> false
# puts [].all? #=> true

# puts '==========================================='

# puts %w[ant bear cat].my_all? { |word| word.length >= 3 } #=> true
# puts %w[ant bear cat].my_all? { |word| word.length >= 4 } #=> false
# # puts %w[ant bear cat].my_all?(/t/) #=> false
# # puts [1, 2i, 3.14].my_all?(Numeric) #=> true
# puts [nil, true, 99].my_all? #=> false
# puts [].my_all? #=> true

# puts '============================================='
# puts '============================================='
# puts %w[ant bear cat].any? { |word| word.length >= 3 } #=> true
# puts %w[ant bear cat].any? { |word| word.length >= 4 } #=> true
# puts %w[ant bear cat].any?(/d/) #=> false
# puts [nil, true, 99].any?(Integer) #=> true
# puts [nil, true, 99].any? #=> true
# puts [].any? #=> false

# puts '============================================='
# puts '============================================='
# puts %w[ant bear cat].my_any? { |word| word.length >= 3 } #=> true
# puts %w[ant bear cat].my_any? { |word| word.length >= 4 } #=> true
# # puts %w[ant bear cat].my_any?(/d/) #=> false
# # puts [nil, true, 99].my_any?(Integer) #=> true
# puts [nil, true, 99].my_any? #=> true
# puts [].my_any? #=> false

puts '==================================================='
puts %w[ant bear cat].none? { |word| word.length == 5 } #=> true
puts %w[ant bear cat].none? { |word| word.length >= 4 } #=> false
# %w{ant bear cat}.none?(/d/)                        #=> true
# [1, 3.14, 42].none?(Float)                         #=> false
puts [].none? #=> true
puts [nil].none? #=> true
puts [nil, false].none? #=> true
puts [nil, false, true].none? #=> false

puts '==================================================='
puts %w[ant bear cat].my_none? { |word| word.length == 5 } #=> true
puts %w[ant bear cat].my_none? { |word| word.length >= 4 } #=> false
# %w{ant bear cat}.none?(/d/)                        #=> true
# [1, 3.14, 42].none?(Float)                         #=> false
puts [].my_none? #=> true
puts [nil].my_none? #=> true
puts [nil, false].my_none? #=> true
puts [nil, false, true].my_none? #=> false
