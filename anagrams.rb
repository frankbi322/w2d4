require 'benchmark'

def first_anagram?(string1,string2)
  array = string1.chars.permutation.to_a
  array.map! do |el|
    el.join("")
  end
  array.include?(string2)
end

# p first_anagram?("reep","peer")

def second_anagram?(string1,string2)
  letters1 = string1.chars
  letters2 = string2.chars
  until letters1.empty?
    letter = letters1.shift
    index = letters2.find_index(letter)
    letters2.delete_at(index) if index
  end
    return true if letters2.empty? && letters1.empty?
    false
end

# p second_anagram?("peer","reap")

def third_anagram?(string1,string2)
  string1.chars.sort == string2.chars.sort
end
#
# p third_anagram?("peer","reap")
# p third_anagram?("peer","reep")

def fourth_anagram?(string1,string2)
  hash1 = Hash.new(0)
  hash2 = Hash.new(0)
  string1.chars.each do |char|
    hash1[char] += 1
  end
  string2.chars.each do |char|
    hash2[char] += 1
  end
  hash1 == hash2



end

# p fourth_anagram?("peer","reap")
# p fourth_anagram?("peer","reep")

def bonus_anagram?(string1,string2)
  hash = Hash.new(0)
  string1.chars.each do |char|
    hash[char] += 1
  end
  string2.chars.each do |char|
    hash[char] -= 1
  end
  hash.values.all? { |val| val == 0 }
end

p bonus_anagram?("peer","reap")
p bonus_anagram?("peer","reep")


string1 = "lordhowell"
string2 = "helloworld"

Benchmark.bm do |x|
  x.report { first_anagram?(string1,string2) }
  x.report { second_anagram?(string1,string2)  }
  x.report { third_anagram?(string1,string2) }
  x.report { fourth_anagram?(string1,string2) }
  x.report { bonus_anagram?(string1,string2) }
end
