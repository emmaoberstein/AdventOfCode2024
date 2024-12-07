def in_bounds(map, pos)
  pos[0] >= 0 && pos[0] < map.length && pos[1] >= 0 && pos[1] < map[0].length
end

def get_step(pos, direction, map)
  [pos[0] + direction[0], pos[1] + direction[1]]
end

def non_cyclical_guard_positions(map, start)
  next_direction = {
    [-1, 0] => [0, 1],
    [0, 1] => [1, 0],
    [1, 0] => [0, -1],
    [0, -1] => [-1, 0],
  }

  visited = { }
  visited_with_direction = { }

  current_pos = start
  current_direction = [-1, 0]

  while in_bounds(map, current_pos)
    return nil if visited_with_direction.key?(current_pos.clone + current_direction.clone) 
    
    visited[current_pos.clone] = true    
    visited_with_direction[current_pos.clone + current_direction.clone] = true

    next_pos = get_step(current_pos, current_direction, map)
    while in_bounds(map, next_pos) && !map[next_pos[0]][next_pos[1]]
      current_direction = next_direction[current_direction]
      next_pos = get_step(current_pos, current_direction, map)
    end

    current_pos = next_pos
  end
    
  visited
end

map = []
start = nil

File.readlines('input.txt', chomp: true).each do |line|
  map.append([])

  symbols = line.split("")
  symbols.each do |symbol|
    map[map.length - 1].append(symbol == '#' ? false : true)
    start = [map.length - 1, map[map.length - 1].length - 1] if symbol ==  '^'
  end
end

puts "part 1"
puts non_cyclical_guard_positions(map, start).keys.count

puts "part 2"
total = 0

map_clone = map.map(&:dup)
map.each_index do |i|
  map[i].each_index do |j|
    if map[i][j]   
      map_clone[i][j] = false
      total+= 1 if non_cyclical_guard_positions(map_clone, start).nil?
      map_clone[i][j] = true
    end
  end
end

puts total