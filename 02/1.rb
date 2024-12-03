def is_report_safe(levels)
  i = 0
  initial_diff = nil
  is_safe = true

  while is_safe and i < levels.length - 1
    diff = levels[i] - levels[i + 1]
    initial_diff = diff if initial_diff == nil
    
    is_safe = false if diff.abs < 1 or diff.abs > 3 or diff.positive? != initial_diff.positive?
   
    i += 1
  end

  is_safe
end

safe_report_count = 0

File.readlines('input.txt', chomp: true).each do |report|
  levels = report.split.map(&:to_i)
  safe_report_count += 1 if is_report_safe(levels)
end

puts safe_report_count