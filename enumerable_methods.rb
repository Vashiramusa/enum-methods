#!/usr/bin/env ruby

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

    result = []
    my_each do |e|
      result.push e if yield e
    end
    result
  end

  # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  def my_all?(arg = nil)
    result = true
    my_each do |element|
      if result
        if block_given?
          result = false unless yield(element)
        elsif arg
          result = element.is_a?(arg) unless arg.is_a?(Regexp)
          result = element.match?(arg) if arg.is_a?(Regexp)
        else
          result = false unless element
        end
      end
    end
    result
  end

  def my_any?(arg = nil)
    result = false
    my_each do |element|
      if result == false
        if block_given?
          result = yield(element)
        elsif arg
          result = element.is_a?(arg) unless arg.is_a?(Regexp)
          result = element.match?(arg) if arg.is_a?(Regexp)
        else
          result = true unless element
        end
      end
    end
    result
  end

  def my_none?(arg = nil)
    result = true
    my_each do |element|
      if result
        if block_given?
          result = false if yield(element)
        elsif arg
          result = !element.is_a?(arg) unless arg.is_a?(Regexp)
          result = !element.match?(arg) if arg.is_a?(Regexp)
        elsif element
          result = false
        end
      end
    end
    result
  end
end
