require 'simplecov'

SimpleCov.start('rails') do
  require 'simplecov-lcov'

  formatter SimpleCov::Formatter::LcovFormatter

  SimpleCov::Formatter::LcovFormatter.config do |c|
    c.report_with_single_file = true
    c.output_directory = 'coverage'
  end

  add_filter ['version.rb', 'initializer.rb']
end

require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods
  include AuthHelper
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end
