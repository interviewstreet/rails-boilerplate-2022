ENV.each { |k, v| env(k, v) }
set :output, 'log/cron.log'
set :environment, ENV['RAILS_ENV']

# Example of using Cron
# every 15.minutes do
#   rake 'cron:email'
# end
