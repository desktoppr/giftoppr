require 'browser_benchmark'

task :benchmark => :environment do
  BrowserBenchmark.new.run(ENV['URL'] || 'http://giftoppr.herokuapp.com/')
end
