def forward_diagonal_match(word, table, i, j)
  return false if j > table[0].length - word.length || i > table[0].length - word.length 
    
  word.each_index do |index|
    return false unless word[index] == table[i+index][j+index]
  end
   
  true
end

def backward_diagonal_match(word, table, i, j)
  return false if j < word.length - 1 || i > table[0].length - word.length 
    
  word.each_index do |index|
    return false unless word[index] == table[i+index][j-index]
  end
   
  true
end

def x_word(word, table, i, j)
  offset = word.length / 2
  
  return (forward_diagonal_match(word, table, i-offset, j-offset) && backward_diagonal_match(word, table, i-offset, j+offset)) ||
    (forward_diagonal_match(word, table, i-offset, j-offset) && backward_diagonal_match(word.reverse, table, i-offset, j+offset))
end

table = []

File.readlines('input.txt', chomp: true).each do |line|
  table.push(line.chars) 
end

total = 0
word = "SAM".chars

table.each_index do |i| 
  table[i].each_index do |j| 
    total += 1 if (x_word(word, table, i, j) || x_word(word.reverse, table, i, j))
  end
end

puts total