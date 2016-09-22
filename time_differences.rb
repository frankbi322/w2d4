require 'benchmark'

def my_min1(list)
  list.each do |el1|
    return el1 if list.all? do |el2|
      el1 <= el2
    end
  end
end

def my_min2(list)
  min = list[0]
  list.each do |el|
    if el < min
      min = el
    end
  end
  min
end

# list = [ 0, 3, 5, 4, -5, 10, 1, 90 ]
# p my_min2(list)  # =>  -5

def largest_contiguous_subsum1(list)
  sum = 0
  list.each_index do |idx1|
    list.each_index do |idx2|
      subsum = 0
      list[idx1..idx2].each do |el|
        subsum += el
      end
      sum = subsum if subsum > sum
    end
  end
  sum
end

def largest_contiguous_subsum2(list)
  largest_sum = list.first
  current_sum = list.first

  list[1..-1].each do |el|
    current_sum = 0 if current_sum < 0
    current_sum += el
    largest_sum = current_sum if  current_sum > largest_sum
  end

  largest_sum
end

# list = [5, 3, -7]
# p largest_contiguous_subsum2(list) # => 8
#
# list = [2, 3, -6, 7, -6, 7]
# p largest_contiguous_subsum2(list)
#
# list = [-5,-1,-3]
# p largest_contiguous_subsum2(list)


list = [2, 3, -6, 7, -6, 7, 10, -15, 20, -5, 4, 3, 400, 11, 13, 17, 19, 20 ,25,27,30,25,-100,20,-45,77,50,706]
Benchmark.bm do |x|
  x.report { largest_contiguous_subsum1(list)}
  x.report { largest_contiguous_subsum2(list) }
end
