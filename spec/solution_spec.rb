require_relative '../solution.rb'

describe 'count_calls_to works for' do
  it 'String#size' do
    n = 1000
    ENV["COUNT_CALLS_TO"] = "String#size"
    Spy.initialize
    (1..n).each do |i|
      i.to_s.size if i.odd?
    end
    expect(Spy.count).to eq(n/2)
  end
  it 'B#foo' do
    module A; def foo; end; end; class B; include A; end;

    n = 1000
    ENV["COUNT_CALLS_TO"] = "B#foo"
    Spy.initialize
    n.times do
      B.new.foo
    end
    expect(Spy.count).to eq(n)
  end
  it 'Array#map!' do
    ENV["COUNT_CALLS_TO"] = "Array#map!"
    Spy.initialize
    n = 500
    ary = []
    (1..n).each do |i|
      ary << i
      ary.map! if i.odd?
    end
    expect(Spy.count).to eq(n/2)
  end
end
