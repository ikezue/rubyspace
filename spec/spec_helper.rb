ENV['RAILS_ENV'] = 'test'

require File.expand_path('../../config/environment', __FILE__)

require 'rspec/rails'
require 'rspec/collection_matchers'

# Require supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and subdirectories.
Dir[Rails.root.join('spec/support/**/*.rb')].each { |file| require file }

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.fail_fast = true
  config.infer_base_class_for_anonymous_controllers = false
  config.order = 'random'

  # Prevent RSpec from wrapping tests in a database transaction.
  config.use_transactional_fixtures = false
end

Capybara.javascript_driver = :webkit
