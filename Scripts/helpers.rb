def run(command)
  puts command
  system(command) or raise "RAKE TASK FAILED: #{command}"
end

