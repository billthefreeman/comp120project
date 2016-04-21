$redis = Redis.new(url: ENV["REDIS_URL" || "redis://localhost:6379/"])

$redis.del("incidents")
$redis.del("people")
$redis.del("phone")
$redis.del("email")
$redis.del("people_group")
$redis.del("group_department")
$redis.del("cates")
$redis.del("statuses")

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



