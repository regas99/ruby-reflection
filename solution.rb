module Spy
  def self.initialize
    puts "initializing Soy for #{ENV["COUNT_CALLS_TO"]}"
    if !ENV["COUNT_CALLS_TO"]
      puts "Spy module called with no ENV['COUNT_CALLS_TO'] set"
      Rails.logger.info("Spy module called with no ENV['COUNT_CALLS_TO'] set")
      return
    end
    @count = 0
    @class, @method = ENV['COUNT_CALLS_TO'].split('#')
  end

  @@instance = self.initialize
end

