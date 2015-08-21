require 'benchmark'
include Benchmark
ENV["COUNT_CALLS_TO"] = "X#y"
require './solution.rb'

# making this a named Proc greatly increases overhead - why??
def test_string_size
  ary = []
  (1..10000000).each do |i|
    i.to_s.size if i.odd?
  end
end

puts "benchmark for String#size"
Benchmark.benchmark(CAPTION, 20, FORMAT, "overhead (1=100%):") do |x|
  t1 = x.report("no spy: ") {test_string_size}
  ENV["COUNT_CALLS_TO"] = "String#size"
  Spy.initialize
  t2 = x.report("with spy:") {test_string_size}
  [(t2/t1)-1]
end
puts "#{Spy.klass}##{Spy.methud} called #{Spy.count} times"

module A
  def foo
  end
end
class B
  include A
end

def test_b_foo
  20000000.times do
    B.new.foo
  end
end

puts "\nbenchmark for B#foo"
Benchmark.benchmark(CAPTION, 20, FORMAT, ">overhead (1=100%):") do |x|
  t1 = x.report("no spy: ") {test_b_foo}
  ENV["COUNT_CALLS_TO"] = "B#foo"
  Spy.initialize
  t2 = x.report("with spy:") {test_b_foo}
  [(t2/t1)-1]
end
puts "#{Spy.klass}##{Spy.methud} called #{Spy.count} times"

def test_arraymap
  ary = []
  (1..1000000).each do |i|
    ary << i
    ary.map!
  end
end

puts "\nbenchmark for Array#map!"
Benchmark.benchmark(CAPTION, 20, FORMAT, ">overhead (1=100%):") do |x|
  t1 = x.report("no spy: ") {test_arraymap}
  ENV["COUNT_CALLS_TO"] = "Array#map!"
  Spy.initialize
  t2 = x.report("with spy:") {test_arraymap}
  [(t2/t1)-1]
end
puts "#{Spy.klass}##{Spy.methud} called #{Spy.count} times"

