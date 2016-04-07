$redis = Redis.new(url: ENV["REDIS_URL" || "redis://localhost:6379/"])
Incident.all.each do |source|
	$redis.zadd('incidents', source.created_at.to_i, source.to_json)
end 

Person.all.each do |source|
	$redis.hset('people', source.id, source.user_name)
end 

Person.all.each do |source|
	$redis.hset('phone', source.id, source.phone)
end

Person.all.each do |source|
	$redis.hset('email', source.id, source.email)
end

Person.all.each do |source|
	$redis.hset('people_group', source.id, source.group.group_name)
end 


Group.all.each do |source|
	$redis.hset('group_department', source.group_name, source.department.department_name)
end


Cate.all.each do |source|
	$redis.hset('cates', source.id, source.cate_name)
end 

Status.all.each do |source|
	$redis.hset('statuses', source.id, source.status_name)
end 

$redis.hset('new_incidents', 'number', 0)


