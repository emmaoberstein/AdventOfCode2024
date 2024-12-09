map_height = 0
map_width = 0
antenna_coords = {}

def is_valid(coord, map_height, map_width)
  coord[0] >= 0 && coord[0] < map_height && coord[1] >= 0 && coord[1] < map_width
end

File.readlines('input.txt', chomp: true).each_with_index do |line, i|
  chars = line.split("")

  map_height += 1
  map_width = chars.length if map_width == 0
  
  chars.each_with_index do |char, j|
    next if char == '.'
    antenna_coords[char] = [] unless antenna_coords.key?(char)
    antenna_coords[char].append([i,j])
  end
end

# part 1
antinodes = {}
antenna_coords.each do |type, coords|
  coords.combination(2).each do |pair|
    offset = [pair[0][0] - pair[1][0], pair[0][1] - pair[1][1]]

    coord = [pair[0][0] + offset[0], pair[0][1] + offset[1]]
    antinodes[coord] = true if is_valid(coord, map_height, map_width)

    coord = [pair[1][0] - offset[0], pair[1][1] - offset[1]]
    antinodes[coord] = true if is_valid(coord, map_height, map_width)
  end
end

puts "part 1: #{antinodes.keys.count}"

# part 2
antinodes = {}
antenna_coords.each do |type, coords|
  coords.combination(2).each do |pair|
    offset = [pair[0][0] - pair[1][0], pair[0][1] - pair[1][1]]

    coord = pair[0]
    while is_valid(coord, map_height, map_width) &&
      antinodes[coord] = true
      coord = [coord[0] + offset[0], coord[1] + offset[1]]
    end

    coord = pair[1]
    while is_valid(coord, map_height, map_width)
      antinodes[coord] = true
      coord = [coord[0] - offset[0], coord[1] - offset[1]]
    end
  end
end

puts "part 2: #{antinodes.keys.count}"