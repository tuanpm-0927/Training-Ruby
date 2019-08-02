ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Setup all fixtures
  fixtures :all
  include ApplicationHelper
  # Add more helper methods to be used by all tests here...
end
