RSpec.configure do |config|
  config.include Warden::Test::Helpers
  Warden.test_mode!
end