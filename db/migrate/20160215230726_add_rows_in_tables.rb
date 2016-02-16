class AddRowsInTables < ActiveRecord::Migration
	def self.up
		Reporter.create(:user_name => "Fanying")
		Reporter.create(:user_name => "Yan")
		Reporter.create(:user_name => "Min")
		Reporter.create(:user_name => "Feiyu")

		Status.create(:status_name => "reported")
		Status.create(:status_name => "processing")
		Status.create(:status_name => "solved")
		Status.create(:status_name => "closed")
		
		Cate.create(:cate_name => "Fire")
		Cate.create(:cate_name => "Construction")
		Cate.create(:cate_name => "Biosafety")
		Cate.create(:cate_name => "Chemical Safety")
		Cate.create(:cate_name => "General Lab Safety")
		Cate.create(:cate_name => "Environmental Public Health")
		Cate.create(:cate_name => "Other")

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

		Incident.create(:location =>"Halligan",:reporter_id=>1,:cate_id=>4,:severity=>3,:status_id=>2)
		Incident.create(:location =>"Anderson",:reporter_id=>2,:cate_id=>5,:severity=>5,:status_id=>3)
		Incident.create(:location =>"Lane",:reporter_id=>1,:cate_id=>2,:severity=>1,:status_id=>1)
		Incident.create(:location =>"Dowling",:reporter_id=>3,:cate_id=>3,:severity=>4,:status_id=>1)
		Incident.create(:location =>"Tisch",:reporter_id=>1,:cate_id=>1,:severity=>3,:status_id=>4)
		Incident.create(:location =>"Barnum",:reporter_id=>3,:cate_id=>6,:severity=>2,:status_id=>3)
		Incident.create(:location =>"Braker",:reporter_id=>2,:cate_id=>7,:severity=>5,:status_id=>2)
	end

	def self.down
	  Reporter.delete_all
	  Status.delete_all
	  Cate.delete_all
	  Department.delete_all
	  Group.delete_all
	  Incident.delete_all
	end
end
