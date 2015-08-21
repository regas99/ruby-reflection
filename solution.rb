module Spy
  attr_reader :count, :class, :method

  def self.initialize
    puts "initializing Spy for #{ENV["COUNT_CALLS_TO"]}"
    @count = 0
    @class, @method = ENV['COUNT_CALLS_TO'].split('#')
    puts "#{@class}##{@method} => #{@count}"
  end

  if ENV["COUNT_CALLS_TO"]
    @@instance = self.initialize
  else
    puts "Spy module called with no ENV['COUNT_CALLS_TO'] set"
  end

end

