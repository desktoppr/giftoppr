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
