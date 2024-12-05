def is_ordered(update, forbidden_graph)
  visited = {}

  update.each do |page|
    if forbidden_graph.key?(page)
      forbidden_graph[page].each do |forbidden|
        return false if visited.key?(forbidden)
      end
    end

    visited[page] = true
  end

  return true
end

forbidden_graph = {}
updates = []

File.readlines('input.txt', chomp: true).each do |line|
  rule = line.split("|").map(&:to_i)
  
  if rule.length > 1
    forbidden_graph[rule[0]] = [] unless forbidden_graph.key?(rule[0])
    forbidden_graph[rule[0]].append(rule[1]) 
  end
  
  update = line.split(",")
  updates.append(update.map(&:to_i)) if update.length > 1
end

# part 1
total = 0
updates.each do |update|
  if is_ordered(update, forbidden_graph)
    total += update[update.length/2]
  end
end

puts "part 1 #{total}"

# part 2
total = 0
updates.each do |update|
  unless is_ordered(update, forbidden_graph)
    new_update = update.sort do |a1,a2| 
      forbidden_graph.key?(a2) && forbidden_graph[a2].include?(a1) ? 1 : -1 
    end
    total += new_update[new_update.length/2]
  end
end

puts "part 2 #{total}"
