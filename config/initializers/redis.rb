$redis = Redis.new(:host => 'localhost', :port => 6379)
Incident.all.each do |source|
	$redis.zadd('incidents', source.created_at.to_i, source.to_json)
end 