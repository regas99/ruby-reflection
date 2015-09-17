RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    # Prevents you from mocking or stubbing a method that does not exist on
    # a real object. This is generally recommended, and will default to
    # `true` in RSpec 4.
    mocks.verify_partial_doubles = true
  end

  # The settings below are suggested to provide a good initial experience
  # with RSpec, but feel free to customize to your heart's content.
  begin
    config.filter_run :focus
    config.run_all_when_everything_filtered = true
    config.disable_monkey_patching!
    if config.files_to_run.one?
      config.default_formatter = 'documentation'
    end

    config.profile_examples = 0 #tfs

    config.order = :random

    Kernel.srand config.seed
  end

end
