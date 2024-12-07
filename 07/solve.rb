def can_equate_to?(target, equation_nums, allow_concat=false, i=0, acc=0)  
  return target == acc if i == equation_nums.length 

  current_num = equation_nums[i]

  can_equate_to?(target, equation_nums, allow_concat, i+1, acc*current_num) || 
  can_equate_to?(target, equation_nums, allow_concat, i+1, acc+current_num) ||
  (allow_concat && can_equate_to?(target, equation_nums, allow_concat, i+1, (acc.to_s+current_num.to_s).to_i))
end


input = {}

File.readlines('input.txt', chomp: true).each do |line|
  value_and_equations = line.split(":")
  input[value_and_equations[0].to_f] = value_and_equations[1].split(" ").map(&:to_i)
end

part_1 = 0
part_2 = 0

input.each do |value, equation_nums|
  part_1 += value if can_equate_to?(value, equation_nums)
  part_2 += value if can_equate_to?(value, equation_nums, true)
end

puts "part 1: #{part_1}, part 2: #{part_2}"