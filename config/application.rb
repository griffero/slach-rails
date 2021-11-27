require_relative 'boot'

require 'rails/all'
Bundler.require(*Rails.groups)

module VovRails
  class Application < Rails::Application
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '/public/*', headers: :any, methods: :get
        resource '/api/*',
          headers: :any,
          expose: ['X-Page', 'X-PageTotal'],
          methods: [:get, :post, :patch, :put, :delete, :options]
      end
    end

    config.i18n.fallbacks = [:es, :en]
    config.i18n.default_locale = 'es-CL'
    config.active_job.queue_adapter = :sidekiq
    config.assets.paths << Rails.root.join('node_modules')
    config.load_defaults 6.0
  end
end
