FactoryGirl.define do 
	factory :incident do
		location { Faker::Address.street_address}
		severity {1}

	    cate_id {1}
	    reporter_id {1}

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