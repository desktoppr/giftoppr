task :benchmark => :environment do
  include Capybara::DSL

  PRODUCTION_URL = ENV['PRODUCTION_URL'] || 'http://giftoppr.herokuapp.com/'

  Capybara.register_driver :selenium_chrome do |app|
    Capybara::Selenium::Driver.new(app, :browser => :chrome)
  end

  Capybara.current_driver = :selenium_chrome
  visit PRODUCTION_URL

  timing = JSON.parse(page.evaluate_script('JSON.stringify(window.performance.timing)'))

  total_time           = timing['loadEventEnd'] - timing['navigationStart']
  dom_ready            = timing['domComplete'] - timing['navigationStart']
  dom_interactive_time = timing['domInteractive'] - timing['navigationStart']

  puts
  puts "TIme until DOM interactive: #{dom_interactive_time}ms"
  puts "Time until DOM is ready:    #{total_time}ms"
  puts "Total load time:            #{total_time}ms"
  puts
end
