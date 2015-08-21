require_relative '../solution.rb'

describe 'counts calls to the specified method' do
  it 'works for String#size' do
    n = 1000
    ENV["COUNT_CALLS_TO"] = "String#size"
    Spy.initialize
    (1..n).each do |i|
      i.to_s.size if i.odd?
    end
    expect(Spy.count).to eq(n/2)
  end
  it 'works for B#foo' do
    module A
      def foo; end
    end
    module B
      include A
    end

    n = 1000
    ENV["COUNT_CALLS_TO"] = "B#foo"
    Spy.initialize
    (1..n).each do |i|
      B.new.foo
    end
    expect(Spy.count).to eq(n)
  end
end
