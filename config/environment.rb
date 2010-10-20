# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
GollumRails3::Application.initialize!

GollumRails3::Application.configure do
  config.load_paths += %W{ #{RAILS_ROOT}/app/mustaches } 
end