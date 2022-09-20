require_relative 'boot'

DOT_ENV_FILES = case ENV['RAILS_ENV']
                when 'production'
                  ['.env.production']
                when 'test'
                  ['.env.test']
                when 'stage'
                  ['.env.stage']
                else
                  ['.env.development']
                end

require 'dotenv'
Dotenv.load(*DOT_ENV_FILES)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RailsBoilerplate
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    # config.web_console.whitelisted_ips = '192.168.0.0/16'
    config.load_defaults 7.0

    config.api_only = true

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.middleware.use OliveBranch::Middleware, inflection: 'camel'

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource(
          '*',
          headers: :any,
          expose: ['Authorization'],
          methods: %i[get patch put delete post options show]
        )
      end
    end
  end
end
