require 'browser_benchmark'

task :benchmark => :environment do
  BrowserBenchmark.new.run(ENV['PRODUCTION_URL'] || 'http://giftoppr.herokuapp.com/')
end
