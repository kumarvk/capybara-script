## Capybara and poltergeist configuration here ##

require 'capybara'
require 'capybara/dsl'
require 'capybara/poltergeist'

module CapybaraWithPoltergeist
  include Capybara::DSL

  # Create a new Poltergeist session in Capybara
  def new_session

    Capybara.configure do |config|
      config.run_server = false
      config.default_driver = :poltergeist
      config.default_selector = :xpath
      config.app_host   = 'http://stuerzer.de/'
    end

    # Start up a new thread
    Capybara::Session.new(:poltergeist)
  end

end