# Based on production defaults
require Rails.root.join("config/environments/production")

beta_host_name = `hostname -s`.chomp[-1]

rubyspace::Application.configure do
  # Include configuration specific to the staging environment here.
end
