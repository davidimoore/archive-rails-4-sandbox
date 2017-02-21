
# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
Dir[Rails.root.join("spec/support/**/*.rb")].sort.each { |file| require file }
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'rspec/mocks'
require 'database_cleaner'

RSpec.configure do |config|
  config.infer_base_class_for_anonymous_controllers = false
  config.infer_spec_type_from_file_location!
  config.use_transactional_fixtures = false
  config.include FactoryGirl::Syntax::Methods
end

ActiveRecord::Migration.maintain_test_schema!
