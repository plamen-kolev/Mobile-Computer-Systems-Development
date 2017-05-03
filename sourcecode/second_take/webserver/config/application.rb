require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module NevenRails
  class Application < Rails::Application


    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :post, :options]
      end
    end
    
    config.i18n.available_locales = [:en, :nb]
    # config.api_only = true
    # config.middleware.insert_before 0, "Rack::Cors" do
    #   allow do
    #     # In development, we don't care about the origin.
    #     origins '*'
    #     # Reminder: On the following line, the 'methods' refer to the 'Access-
    #     # Control-Request-Method', not the normal Request Method.
    #     resource '*', :headers => :any, :methods => [:get, :post, :options, :delete, :put, :patch], credentials: true
    #   end
    # end
  end
end
