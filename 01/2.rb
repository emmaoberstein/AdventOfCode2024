similarity = 0
left_list = []
right_list = []

File.readlines('input.txt', chomp: true).each do |line|
  split = line.split
  left_list.append(split[0].to_i)
  right_list.append(split[1].to_i)
end

left_tally = left_list.tally
right_tally = right_list.tally

left_tally.each do |key, val|
  similarity += (key.to_i * right_tally[key].to_i) if right_tally.key?(key) 
end

puts similarity