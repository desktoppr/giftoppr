worker_processes (ENV['WORKERS'] || 3).to_i
timeout 30
preload_app true

if pidfile = ENV['PIDFILE']
  pid pidfile
end

if ENV['LISTEN']
  listen ENV['LISTEN']
else
  port = ENV['PORT'].to_i
  listen port, :tcp_nopush => false
end

# Master process disconnects from active record so it is not available
# to children.
before_fork do |server, worker|
  ActiveRecord::Base.connection.disconnect!
end

# Children each create a new active record connection.
after_fork do |server, worker|
  ActiveRecord::Base.establish_connection
end
