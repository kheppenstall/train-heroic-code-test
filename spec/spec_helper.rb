require 'rspec'
require 'capybara/rspec'
require 'capybara/dsl'
require 'selenium-webdriver'
require 'byebug'
require 'faker'

model_paths  = File.join(Dir.pwd, 'spec', 'models', '**', '*.rb')
Dir.glob(model_paths).each { |file| require file }

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.default_driver = :chrome
Capybara.app_host = "https://chgainz.trainheroic.com"
Capybara.default_max_wait_time = 60

RSpec.configure do |config|
  config.before(:each) do
    config.include Capybara::DSL
  end
end
