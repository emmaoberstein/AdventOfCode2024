def horizontal_match(word, table, i, j)
  return false if j > table[0].length - word.length 
    
  word.each_index do |index|
    return false unless word[index] == table[i][j+index]
  end
  
  true
end

def vertical_match(word, table, i, j)
  return false if i > table[0].length - word.length 
    
  word.each_index do |index|
    return false unless word[index] == table[i+index][j]
  end
  
  true
end

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

def word_count(word, table, i, j)
  count = 0
  count +=1 if horizontal_match(word, table, i, j)
  count +=1 if vertical_match(word, table, i, j)
  count +=1 if forward_diagonal_match(word, table, i, j)
  count +=1 if backward_diagonal_match(word, table, i, j)

  count
end


table = []

File.readlines('input.txt', chomp: true).each do |line|
  table.push(line.chars) 
end

total = 0
word = "XMAS".chars

table.each_index do |i| 
  table[i].each_index do |j| 
    total += word_count(word, table, i, j) + word_count(word.reverse, table, i, j)
  end
end

puts total