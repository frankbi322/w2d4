require 'benchmark'

def bad_two_sum?(arr, target_sum)
  every_pair = []
  arr.each do |el1|
    arr.each do |el2|
      next if el1 == el2
      every_pair << [el1,el2].sort unless every_pair.include?([el1,el2].sort)
    end
  end
  every_pair.each do |pair|
    return true if pair[0] + pair[1] == target_sum
  end
  false
end
#
# arr = [0, 1, 5, 7]
# p bad_two_sum?(arr, 6) # => should be true
# p bad_two_sum?(arr, 10)

def okay_two_sum?(arr, target_sum)
  sorted = arr.sort
  idx1 = 0
  idx2 = arr.length-1
  until idx1 == idx2
    sum = arr[idx1] + arr[idx2]
    return true if sum == target_sum
    if sum > target_sum
      idx2 -= 1
    else
      idx1 += 1
    end
  end
  false
end
#
# arr = [0, 1, 5, 7]
# p okay_two_sum?(arr, 6) # => should be true
# p okay_two_sum?(arr, 10)

def two_sum?(arr, target_sum)
  complements = {}

  arr.each do |el|
    return true if complements[target_sum - el]
    complements[el] = true
  end

  false
end


# def two_sum?(arr,target_sum)
#   hash = Hash.new(0)
#   arr.each do |el|
#     hash[el] += 1
#   end
#   hash.each do |key,value|
#     hash[key] -= 1
#     return true if hash[target_sum-key] >= 1
#   end
#   false
# end


arr = [0, 1, 2, 3, 4, 5, 7, 9, 11, 20, 21, 23, 25, 28, 500]
# p two_sum?(arr, 6) # => should be true
# p two_sum?(arr, 10)



Benchmark.bm do |x|
  x.report { bad_two_sum?(arr,6) }
  x.report { okay_two_sum?(arr,6)   }
  x.report { two_sum?(arr,6) }
end
