require 'active_support/all'
require 'capybara/rspec'
require 'capybara-screenshot/rspec'
require 'selenium-webdriver'

RSpec.configure do |config|
  Capybara.app_host = 'http://yandex.ru'
  Capybara.run_server = false

  Capybara.register_driver :chrome do |app|
    Capybara::Selenium::Driver.new(app, :browser => :chrome,
              desired_capabilities: { "chromeOptions" => { "args" => %w{ --start-maximized --disable-infobars },
                                      "prefs" => { "download.prompt_for_download" => true } } })
  end

  Capybara.save_path = './tmp/capybara'
  Capybara.javascript_driver = :chrome
  Capybara.default_driver = Capybara.javascript_driver
  Capybara.default_max_wait_time = 5

  Capybara::Screenshot.register_driver :chrome do |driver, path|
    driver.browser.save_screenshot(path)
  end

  config.expect_with :rspec do |expectations|
    # This option will default to `true` in RSpec 4. It makes the `description`
    # and `failure_message` of custom matchers include text for helper methods
    # defined using `chain`, e.g.:
    #     be_bigger_than(2).and_smaller_than(4).description
    #     # => "be bigger than 2 and smaller than 4"
    # ...rather than:
    #     # => "be bigger than 2"
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  # rspec-mocks config goes here. You can use an alternate test double
  # library (such as bogus or mocha) by changing the `mock_with` option here.
  config.mock_with :rspec do |mocks|
    # Prevents you from mocking or stubbing a method that does not exist on
    # a real object. This is generally recommended, and will default to
    # `true` in RSpec 4.
    mocks.verify_partial_doubles = true
  end

  # This option will default to `:apply_to_host_groups` in RSpec 4 (and will
  # have no way to turn it off -- the option exists only for backwards
  # compatibility in RSpec 3). It causes shared context metadata to be
  # inherited by the metadata hash of host groups and examples, rather than
  # triggering implicit auto-inclusion in groups with matching metadata.
  config.shared_context_metadata_behavior = :apply_to_host_groups
end
