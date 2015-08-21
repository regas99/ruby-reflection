module Spy
  attr_reader :count, :class, :method

  def self.initialize
    puts "initializing Spy for #{ENV["COUNT_CALLS_TO"]}"
    @count = 0
    @class, @method = ENV['COUNT_CALLS_TO'].split('#')
    puts "#{@class}##{@method} => #{@count}"
  end

  def self.increment
    @count += 1
  end

  # instantiate singleton
  if ENV["COUNT_CALLS_TO"]
    @@instance = self.initialize
  else
    puts "Spy module called with no ENV['COUNT_CALLS_TO'] set"
  end

  def get_class
    # set or create the class
    if Object.const_defined?(@class)
      Object.const_get(@class)
    else
      Object.const_set(@class, Class.new)
    end
  end

  def set_method
    klazz = self.get_class
    klazz::class_eval do
      if method_defined?(@method)
        # save an existing method
        alias_method :real_method, @method
      else
        # or create a noop method
        define_method :real_method do; end;
      end
    end
    define_method @method do
      increment
      real_method
    end
  end

end

