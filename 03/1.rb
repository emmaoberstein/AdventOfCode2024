count = 0

File.read("input.txt").scan(/mul\([0-9]*,[0-9]*\)/).each do |mul|
  nums = mul.scan(/\d+/).map(&:to_i)
  count += (nums[0] * nums[1])
end

puts count