def is_report_safe(levels, allowed_removals: 1)
  i = 0

  while i < levels.length - 1
    diff = levels[i] - levels[i + 1]
    initial_diff = diff if initial_diff == nil
    
    if diff.abs < 1 or diff.abs > 3 or diff.positive? != initial_diff.positive?
      return allowed_removals > 0 && (i-1..i+1).any? do |to_delete| 
        is_report_safe(levels.reject.with_index{|val, index| index == to_delete }, allowed_removals: allowed_removals - 1) 
      end  
    end

    i += 1
  end

  true
end

safe_report_count = 0

File.readlines('input.txt', chomp: true).each do |report|
  levels = report.split.map(&:to_i)
  safe_report_count += 1 if is_report_safe(levels)
end

puts safe_report_count