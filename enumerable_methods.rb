#!/usr/bin/env ruby

# frozen_string_literal: true

module Enumerable # rubocop:disable Metrics/ModuleLength
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

    result = []
    my_each do |e|
      result.push e if yield e
    end
    result
  end

  # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  def my_all?(arg = nil)
    if block_given?
      my_each { |element| return false unless yield(element) }
    elsif arg.class == Class
      my_each { |element| return false unless element.class.ancestors.include? arg }
    elsif arg.class == Regexp
      my_each { |element| return false unless element =~ arg }
    elsif arg.nil?
      my_each { |element| return false unless element }
    else
      my_each { |element| return false unless element == arg }
    end
    true
  end

  def my_any?(arg = nil)
    if block_given?
      my_each { |element| return true if yield element }
    elsif arg.class == Class
      my_each { |element| return true if element.class.ancestors.include? arg }
    elsif arg.class == Regexp
      my_each { |element| return true if arg =~ element }
    elsif arg.nil?
      my_each { |element| return true if element }
    else
      my_each { |element| return true if element == arg }
    end
    false
  end

  def my_none?(arg = nil)
    if block_given?
      my_each { |element| return false if yield element }
    elsif arg.class == Class
      my_each { |element| return false if element.class.ancestors.include? arg }
    elsif arg.class == Regexp
      my_each { |element| return false if arg =~ element }
    elsif arg.nil?
      my_each { |element| return false if element }
    else
      my_each { |element| return false if element == arg }
    end
    true
  end

  def my_count(arg = nil)
    count = 0
    if block_given?
      my_each { |element| count += 1 if yield(element) }
    elsif arg.nil?
      my_each { |_element| count += 1 }
    else
      my_each { |element| count += 1 if element == arg }
    end
    count
  end

  def my_map
    return to_enum unless block_given?

    result = []
    if self.class == Range
      to_a.my_each_with_index { |element, index| result[index] = yield element }
    else
      my_each_with_index { |element, index| result[index] = yield element }
    end
    result
  end

  def my_inject(*args)
    arr = to_a.dup
    if args[0].nil?
      operand = arr.shift
    elsif args[1].nil? && !block_given?
      symbol = args[0]
      operand = arr.shift
    elsif args[1].nil? && block_given?
      operand = args[0]
    else
      operand = args[0]
      symbol = args[1]
    end

    arr[0..-1].my_each do |i|
      operand = if symbol
                  operand.send(symbol, i)
                else
                  yield(operand, i)
                end
    end
    operand
  end
end
# rubocop:enable  Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
def multiply_els(arr = [])
  arr.my_inject(:*)
end
