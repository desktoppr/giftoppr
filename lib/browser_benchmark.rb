class BrowserBenchmark
  include Capybara::DSL

  def initialize
    Capybara.register_driver(:selenium_chrome) { |app| Capybara::Selenium::Driver.new(app, :browser => :chrome) }
    Capybara.current_driver = :selenium_chrome

    @results = BenchmarkResults.new
  end

  def run(url)
    5.times do
      Capybara.reset_sessions!

      visit url
      page.has_css?('body')
      sleep 0.25

      timing = JSON.parse(page.evaluate_script('JSON.stringify(window.performance.timing)'))
      @results.add(timing)
    end

    puts @results
  end
end

class BenchmarkResults
  def initialize
    @load_event_end_times  = Result.new
    @dom_complete_times    = Result.new
    @dom_interactive_times = Result.new
  end

  def add(timing)
    @load_event_end_times  << timing['loadEventEnd']   - timing['navigationStart']
    @dom_complete_times    << timing['domComplete']    - timing['navigationStart']
    @dom_interactive_times << timing['domInteractive'] - timing['navigationStart']
  end

  def to_s
    %{
                   Low       Median    High
DOM interactive:   #{@dom_interactive_times}
DOM ready:         #{@dom_complete_times}
Total load:        #{@load_event_end_times}
}
  end
end

class Result < Array
  def to_s
    lowest_s + median_s + highest_s
  end

  private

  def lowest_s
    "#{min}ms".ljust(10).colorize(:green)
  end

  def median_s
    "#{median}ms".ljust(10).colorize(:blue)
  end

  def highest_s
    "#{max}ms".ljust(10).colorize(:red)
  end

  def median(&blk)
    values = blk ? map( &blk ) : self
    values[ values.length / 2 ]
  end
end
