$redis = Redis.new(url: ENV["REDIS_URL" || "redis://localhost:6379/"])
Incident.all.each do |source|
	$redis.zadd('incidents', source.created_at.to_i, source.to_json)
end 