require 'benchmark'

def windowed_max_range(array,w)
  current_max_range = nil

  array.each_index do |idx1|
    idx2 = idx1 + w -1
      next if idx2 >= array.length
      current_window = array[idx1..idx2]
      local_min = current_window.first
      local_max = current_window.first

      current_window.each do |el|
        local_min = el if el < local_min
        local_max = el if el > local_max
      end

      local_range = local_max - local_min
      current_max_range = local_range if current_max_range.nil? ||local_range > current_max_range
  end
  current_max_range
end
# stack queue =  1 0
#  2, 5, 4, 8]
# p windowed_max_range([1, 0, 2, 5, 4, 8], 2) #== 4 # 4, 8
# p windowed_max_range([1, 0, 2, 5, 4, 8], 3) #== 5 # 0, 2, 5
# p windowed_max_range([1, 0, 2, 5, 4, 8], 4) #== 6 # 2, 5, 4, 8
# p windowed_max_range([1, 3, 2, 5, 4, 8], 5) #== 6 # 3, 2, 5, 4, 8

class MyQueue
  def initialize
    @store = []
  end

  def enqueue(el)
    @store << el
  end

  def dequeue
    @store.shift
  end

  def peek
    @store
  end

  def size
    @store.length
  end

  def empty?
    @store.empty?
  end
end

class MyStack

  attr_reader :max, :min

  def initialize
    @store = []
    @max = nil
    @min = nil
  end

  def push(el)
    if max.nil? || el > @max
      @max = el
    end
    if min.nil? || el < @min
      @min = el
    end
    @store << {:el => el, :min => @min, :max => @max}
  end

  def pop
    removed_value = @store.pop
    if empty?
      @min = nil
      @max = nil
    else
      @min = peek[:min]
      @max = peek[:max]
    end
    removed_value[:el]
  end

  def peek
    @store.last
  end

  def size
    @store.length
  end

  def empty?
    @store.empty?
  end


end

class StackQueue
  def initialize
    @store = [MyStack.new,MyStack.new]
  end

  def enqueue(el)
    @store[0].push(el)
  end

  def dequeue
    until @store[0].empty?
      @store[1].push(@store[0].pop)
    end
    results = @store[1].pop
    until @store[1].empty?
      @store[0].push(@store[1].pop)
    end
    results
  end

  def peek
    @store[0].peek
  end

  def max
    @store[0].max
  end

  def min
    @store[0].min
  end

  def size
    @store[0].size
  end

  def empty?
    @store[0].empty?
  end
end

def good_windowed_max_range(array,w)
  stack_queue = StackQueue.new
  best_range = 0
  copy = array.dup

  w.times do
    stack_queue.enqueue(copy.shift)
  end

  best_range = stack_queue.max - stack_queue.min

  (array.length-w).times do
    stack_queue.enqueue(copy.shift)
    stack_queue.dequeue
    current_range = stack_queue.max - stack_queue.min
    best_range = current_range if current_range > best_range
  end
  best_range
end

# p good_windowed_max_range([1, 0, 2, 5, 4, 8], 2) #== 4 # 4, 8
# p good_windowed_max_range([1, 0, 2, 5, 4, 8], 3) #== 5 # 0, 2, 5
# p good_windowed_max_range([1, 0, 2, 5, 4, 8], 4) #== 6 # 2, 5, 4, 8
# p good_windowed_max_range([1, 3, 2, 5, 4, 8], 5) #== 6 # 3, 2, 5, 4, 8

array = [1, 0, 2, 5, 4, 8,9,2,4,7,6,5,3,4,5,7,6,8,4,5,2,3,4,5,1,1,50,80,90,7,6,7,5,50,4,3,5,2,1]

Benchmark.bm do |x|
  x.report { windowed_max_range(array,3)}
  x.report { good_windowed_max_range(array,3)}
  x.report { windowed_max_range(array,4)}
  x.report { good_windowed_max_range(array,4)}
end
