# Rake task to run before 'spec' task, to check factory validity.
# http://robots.thoughtbot.com/testing-your-factories-first

if defined?(RSpec)
  desc 'Run factory specs.'
  RSpec::Core::RakeTask.new(:factory_specs) do |t|
    t.pattern = './spec/factories_spec.rb'
  end
end

task spec: :factory_specs
