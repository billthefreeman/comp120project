FactoryGirl.define do 
	factory :incident do
		location { Faker::Address.street_address}
		severity {1}

	    cate_id {Cate.create(:cate_name=>'fire').id}
	    Cate.create(:cate_name=>'chemical')
	    reporter_id {Person.create(:last_name=>'ye',
			    	:user_name=>'fye',
			    	:phone=>'1234567',
			    	:group_id=>Group.create(:group_name=>'g1',:department_id=>Department.create(:department_name=>'d1')).id
			    	).id
					}

		factory :invalid_incident_no_location do
	      location nil
	    end

	    factory :invalid_incident_no_severity do
	      severity nil
	    end

	    factory :invalid_incident_no_cate do
	      location nil
	    end
	end
end