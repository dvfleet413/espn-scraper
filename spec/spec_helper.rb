require "bundler/setup"
require_relative "../lib/ESPNScraper/version.rb"
require_relative "../lib/ESPNScraper/cli.rb"
require_relative "../lib/ESPNScraper/article.rb"
require_relative "../lib/ESPNScraper/scraper.rb"
require_relative "../lib/ESPNScraper/teams.rb"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
