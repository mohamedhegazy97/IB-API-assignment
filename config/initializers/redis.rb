$redis = Redis::Namespace.new("dashboard:#{Rails.env}", redis: Redis.new(host: "redis", port: 6379, db: 0))