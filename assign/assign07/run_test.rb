#! /usr/bin/env ruby

raise "Usage: run_test.rb <testname>" if ARGV.length != 1
testname = ARGV.shift

input_file = "input/#{testname}.in"
expected_output_file = "expected_output/#{testname}.out"
actual_output_file = "actual_output/#{testname}.out"

# run the test
system("mkdir -p actual_output")
rc = system("./apcalc < #{input_file} > #{actual_output_file}")
if !rc
  STDERR.puts "apcalc program failed (killed by signal or nonzero exit code)"
  exit 1
end

# check actual output against expected output
rc = system("diff #{expected_output_file} #{actual_output_file} > /dev/null")
if !rc
  puts "Program output did not match expected output"
  exit 1
end

# success!
puts "Program output matched expected output"
exit 0
