module Spy
  def self.count
    @count
  end
  def self.klass
    @klass
  end
  def self.methud
    @methud
  end
  def self.increment
    @count += 1
  end

  def self.set_klass
    # set or create the klass
    if Object.const_defined?(@klass)
      Object.const_get(@klass)
    else
      Object.const_set(@klass, Class.new)
    end
  end

  def self.set_methud
    klazz = self.set_klass
    klazz::class_eval do
      if method_defined?(Spy.methud)
        # save an existing method
        alias_method :real_method, Spy.methud
      else
        # or create a noop method
        define_method :real_method do; end;
      end
    end
    puts "methud is #{Spy.methud}"
    define_method Spy.methud do
      increment
      real_method
    end
  end

  def self.initialize
    puts "initializing Spy for #{ENV["COUNT_CALLS_TO"]}"
    @count = 0
    @klass, @methud = ENV['COUNT_CALLS_TO'].split('#')
    set_methud
    self
  end




  # instantiate singleton
  if ENV["COUNT_CALLS_TO"]
    @@instance = Spy.initialize
    puts "singleton is #{@@instance.inspect}"
  else
    puts "Spy module called with no ENV['COUNT_CALLS_TO'] set"
  end



end

ObjectSpace.define_finalizer(
  ENV,
  proc{ |id| puts "#{Spy.klass}# #{Spy.methud} called #{Spy.count} times" }
  )



