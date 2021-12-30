redis_config = Rails.application.config_for(:redis)
REDIS_CONNECTION = Redis.new(redis_config)
