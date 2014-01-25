# Refs:
# => http://devblog.avdi.org/2012/08/31/configuring-database_cleaner-with-rails-rspec-capybara-and-selenium/
# => http://blog.bignerdranch.com/1617-sane-rspec-config-for-clean-and-slightly-faster-specs/
# => https://github.com/bmabey/database_cleaner

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  # Use the truncation strategy for Capybara specs. These run in a separate
  # thread with a different database connection and would not work well with
  # the transaction strategy.
  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
