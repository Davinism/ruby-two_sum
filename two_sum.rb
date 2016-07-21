require "byebug"

def bad_two_sum?(arr, val)
  (0...arr.length - 1).each do |i|
    (i + 1...arr.length).each do |j|
      return true if arr[i] + arr[j] == val
    end
  end
  false
end


def okay_two_sum?(arr, val)
  arr2 = arr.merge_sort
  arr2.each_with_index do |el, i|
    temp = arr2.dup
    temp.delete_at(i)
    return true unless bsearch(temp, val - el).nil?
  end
  false
end

class Array
  def merge_sort
    return self if count < 2
    middle = count / 2
    left, right = self.take(middle), self.drop(middle)
    sorted_left, sorted_right = left.merge_sort, right.merge_sort
    merge(sorted_left, sorted_right)
  end

  def merge(left, right)
    merged_array = []
    until left.empty? || right.empty?
      merged_array <<
        ((left.first < right.first) ? left.shift : right.shift)
    end
    merged_array + left + right
  end
end

def bsearch(nums, target)
  return nil if nums.empty?
  probe_index = nums.length / 2
  case target <=> nums[probe_index]
  when -1
    bsearch(nums.take(probe_index), target)
  when 0
    probe_index
  when 1
    sub_answer = bsearch(nums.drop(probe_index + 1), target)
    (sub_answer.nil?) ? nil : (probe_index + 1) + sub_answer
  end
end

def pair_sums?(arr, val)
  hash = Hash.new
  (0...arr.length).each do |i|
    hash["#{i}"] = arr[i]
  end
  arr.each_with_index do |el, i|
    if hash.has_value?(val - el) && hash.key(val - el).to_i != i
      return true
    end
  end
  false
end
