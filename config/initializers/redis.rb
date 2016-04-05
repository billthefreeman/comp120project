$redis = Redis.new(url: ENV["REDIS_URL"])
Incident.all.each do |source|
	$redis.zadd('incidents', source.created_at.to_i, source.to_json)
end 