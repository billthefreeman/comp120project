# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
case Rails.env
when "production"
    Status.create(:status_name => "reported")
	Status.create(:status_name => "processing")
	Status.create(:status_name => "solved")
	Status.create(:status_name => "closed")
	
	Cate.create(:cate_name => "Animals and Animal Safety")
	Cate.create(:cate_name => "Asbestos")
	Cate.create(:cate_name => "Biological Agents")
	Cate.create(:cate_name => "Bloodborne Pathogens")
	Cate.create(:cate_name => "Chemical")
	Cate.create(:cate_name => "Confined Space")
	Cate.create(:cate_name => "Cold")
	Cate.create(:cate_name => "Construction")
	Cate.create(:cate_name => "Cranes and Hoists")
	Cate.create(:cate_name => "Driving")
	Cate.create(:cate_name => "Dust")
	Cate.create(:cate_name => "Electrical")
	Cate.create(:cate_name => "Ergonomics")
	Cate.create(:cate_name => "Fire")
	Cate.create(:cate_name => "Hazardous Waste")
	Cate.create(:cate_name => "Heat")
	Cate.create(:cate_name => "Indoor Air Quality")
	Cate.create(:cate_name => "Lab Safety")
	Cate.create(:cate_name => "Lead")
	Cate.create(:cate_name => "Medical")
	Cate.create(:cate_name => "Mold")
	Cate.create(:cate_name => "Oil and Gas")
	Cate.create(:cate_name => "Radiation")
	Cate.create(:cate_name => "Scaffolding")
	Cate.create(:cate_name => "Training")
	Cate.create(:cate_name => "Unknown")

	Department.create(:department_name => "Dining")
	Department.create(:department_name => "Energy and Facilities")
	Department.create(:department_name => "Environmental Health and Safety")
	Department.create(:department_name => "Housing")
	Department.create(:department_name => "Mail and Print")
	Department.create(:department_name => "Sustainability")
	Department.create(:department_name => "Events Management")
	Department.create(:department_name => "Sustainability, and Transportation")

	Group.create(:group_name => "Buildings and Facilities", :department_id => 3)
	Group.create(:group_name => "Construction Support", :department_id => 3)
	Group.create(:group_name => "Environmental Management", :department_id => 3)
	Group.create(:group_name => "Laboratories", :department_id => 3)
	Group.create(:group_name => "Training", :department_id => 3)

	Person.create(:last_name => "Ye", :user_name => "Fanying",:group_id => 1,:phone=>"8672729666",:email=>"123@tufts.edu",:encrypted_password=>"$2a$10$IKISercM6.3Fp/yeM9vxsuRCScC2z8QB3OjV5nwX7lwYMoMyQo5e.")
	Person.create(:last_name => "Huo",:user_name => "Yan",:group_id => 2,:phone=>"8672729667",:email=>"234@tufts.edu",:encrypted_password=>"$2a$10$IKISercM6.3Fp/yeM9vxsuRCScC2z8QB3OjV5nwX7lwYMoMyQo5e.")
	Person.create(:last_name => "Bu",:user_name => "Min",:group_id => 3,:phone=>"8672729668",:email=>"345@tufts.edu",:encrypted_password=>"$2a$10$IKISercM6.3Fp/yeM9vxsuRCScC2z8QB3OjV5nwX7lwYMoMyQo5e.")
	Person.create(:last_name => "Lu",:user_name => "Feiyu",:group_id => 4,:phone=>"8672729669",:email=>"456@tufts.edu",:encrypted_password=>"$2a$10$IKISercM6.3Fp/yeM9vxsuRCScC2z8QB3OjV5nwX7lwYMoMyQo5e.")
	
	Incident.create(:location =>"Halligan",:reporter_id=>1,:cate_id=>14,:severity=>3,:status_id=>2)
	Incident.create(:location =>"Anderson",:reporter_id=>2,:cate_id=>5,:severity=>5,:status_id=>3)
	Incident.create(:location =>"Lane",:reporter_id=>1,:cate_id=>2,:severity=>1,:status_id=>1)
	Incident.create(:location =>"Dowling",:reporter_id=>3,:cate_id=>3,:severity=>4,:status_id=>1)
	Incident.create(:location =>"Tisch",:reporter_id=>1,:cate_id=>1,:severity=>3,:status_id=>4)
	Incident.create(:location =>"Barnum",:reporter_id=>3,:cate_id=>6,:severity=>2,:status_id=>3)
	Incident.create(:location =>"Braker",:reporter_id=>2,:cate_id=>7,:severity=>5,:status_id=>2)

	Conversation.create(:sender_id =>1, :recipient_id=>2)
	Conversation.create(:sender_id =>1, :recipient_id=>3)
	Conversation.create(:sender_id =>1, :recipient_id=>4)
	#Conversation.create(:sender_id =>2, recipient_id=>1)
	Conversation.create(:sender_id =>2, :recipient_id=>3)
	Conversation.create(:sender_id =>2, :recipient_id=>4)
	#Conversation.create(:sender_id =>3, recipient_id=>1)
	#Conversation.create(:sender_id =>3, recipient_id=>2)
	Conversation.create(:sender_id =>3, :recipient_id=>4)
	#Conversation.create(:sender_id =>4, recipient_id=>1)
	#Conversation.create(:sender_id =>4, recipient_id=>2)
	#Conversation.create(:sender_id =>4, recipient_id=>3)

	Message.create(:body=>"hi" , :conversation_id=>1, :person_id=>1)
	
when "development"
	Status.create(:status_name => "reported")
	Status.create(:status_name => "processing")
	Status.create(:status_name => "solved")
	Status.create(:status_name => "closed")
	
	Cate.create(:cate_name => "Animals and Animal Safety")
	Cate.create(:cate_name => "Asbestos")
	Cate.create(:cate_name => "Biological Agents")
	Cate.create(:cate_name => "Bloodborne Pathogens")
	Cate.create(:cate_name => "Chemical")
	Cate.create(:cate_name => "Confined Space")
	Cate.create(:cate_name => "Cold")
	Cate.create(:cate_name => "Construction")
	Cate.create(:cate_name => "Cranes and Hoists")
	Cate.create(:cate_name => "Driving")
	Cate.create(:cate_name => "Dust")
	Cate.create(:cate_name => "Electrical")
	Cate.create(:cate_name => "Ergonomics")
	Cate.create(:cate_name => "Fire")
	Cate.create(:cate_name => "Hazardous Waste")
	Cate.create(:cate_name => "Heat")
	Cate.create(:cate_name => "Indoor Air Quality")
	Cate.create(:cate_name => "Lab Safety")
	Cate.create(:cate_name => "Lead")
	Cate.create(:cate_name => "Medical")
	Cate.create(:cate_name => "Mold")
	Cate.create(:cate_name => "Oil and Gas")
	Cate.create(:cate_name => "Radiation")
	Cate.create(:cate_name => "Scaffolding")
	Cate.create(:cate_name => "Training")
	Cate.create(:cate_name => "Unknown")

	Department.create(:department_name => "Dining")
	Department.create(:department_name => "Energy and Facilities")
	Department.create(:department_name => "Environmental Health and Safety")
	Department.create(:department_name => "Housing")
	Department.create(:department_name => "Mail and Print")
	Department.create(:department_name => "Sustainability")
	Department.create(:department_name => "Events Management")
	Department.create(:department_name => "Sustainability, and Transportation")

	Group.create(:group_name => "Buildings and Facilities", :department_id => 3)
	Group.create(:group_name => "Construction Support", :department_id => 3)
	Group.create(:group_name => "Environmental Management", :department_id => 3)
	Group.create(:group_name => "Laboratories", :department_id => 3)
	Group.create(:group_name => "Training", :department_id => 3)

	Person.create(:last_name => "Robert", :user_name => "Robert",:group_id => 1,:phone=>"9672729666",:email=>"111@tufts.edu",:encrypted_password=>"$2a$10$IKISercM6.3Fp/yeM9vxsuRCScC2z8QB3OjV5nwX7lwYMoMyQo5e.")
	Person.create(:last_name => "Service", :user_name => "Customer_Service",:group_id => 1,:phone=>"9972729666",:email=>"222@tufts.edu",:encrypted_password=>"$2a$10$IKISercM6.3Fp/yeM9vxsuRCScC2z8QB3OjV5nwX7lwYMoMyQo5e.")
	Person.create(:last_name => "Ye", :user_name => "Fanying",:group_id => 1,:phone=>"8672729666",:email=>"123@tufts.edu",:encrypted_password=>"$2a$10$IKISercM6.3Fp/yeM9vxsuRCScC2z8QB3OjV5nwX7lwYMoMyQo5e.")
	Person.create(:last_name => "Huo",:user_name => "Yan",:group_id => 2,:phone=>"8672729667",:email=>"234@tufts.edu",:encrypted_password=>"$2a$10$IKISercM6.3Fp/yeM9vxsuRCScC2z8QB3OjV5nwX7lwYMoMyQo5e.")
	Person.create(:last_name => "Bu",:user_name => "Min",:group_id => 3,:phone=>"8672729668",:email=>"345@tufts.edu",:encrypted_password=>"$2a$10$IKISercM6.3Fp/yeM9vxsuRCScC2z8QB3OjV5nwX7lwYMoMyQo5e.")
	Person.create(:last_name => "Lu",:user_name => "Feiyu",:group_id => 4,:phone=>"8672729669",:email=>"456@tufts.edu",:encrypted_password=>"$2a$10$IKISercM6.3Fp/yeM9vxsuRCScC2z8QB3OjV5nwX7lwYMoMyQo5e.")

	Incident.create(:location =>"Halligan",:reporter_id=>11,:cate_id=>4,:severity=>3,:status_id=>2)
	Incident.create(:location =>"Anderson",:reporter_id=>12,:cate_id=>5,:severity=>5,:status_id=>3)
	Incident.create(:location =>"Lane",:reporter_id=>11,:cate_id=>2,:severity=>1,:status_id=>1)
	Incident.create(:location =>"Dowling",:reporter_id=>13,:cate_id=>3,:severity=>4,:status_id=>1)
	Incident.create(:location =>"Tisch",:reporter_id=>11,:cate_id=>1,:severity=>3,:status_id=>4)
	Incident.create(:location =>"Barnum",:reporter_id=>13,:cate_id=>6,:severity=>2,:status_id=>3)
	Incident.create(:location =>"Braker",:reporter_id=>12,:cate_id=>7,:severity=>5,:status_id=>2)
end