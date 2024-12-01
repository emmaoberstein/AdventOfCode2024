distance = 0
left_list = []
right_list = []

File.readlines('input.txt', chomp: true).each do |line|
  split = line.split
  left_list.append(split[0].to_i)
  right_list.append(split[1].to_i)
end

left_list.sort!
right_list.sort!

left_list.each_with_index do |val, idx|
  distance += (val - right_list[idx]).abs
end

puts distance