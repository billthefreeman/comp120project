require 'rails_helper'

describe Incident do 

	it "should belongs to reporter" do
	    t = Incident.reflect_on_association(:reporter)
	    expect(t.macro).to eq :belongs_to
  	end

  	it "should belongs to assignee" do
	    t = Incident.reflect_on_association(:assignee)
	    expect(t.macro).to eq :belongs_to
  	end

  	it "should belongs to cate" do
	    t = Incident.reflect_on_association(:cate)
	    expect(t.macro).to eq :belongs_to
  	end

  	it "should belongs to status" do
	    t = Incident.reflect_on_association(:status)
	    expect(t.macro).to eq :belongs_to
  	end

	it "is invalid without a location" do
		create(:cate, cate_name: 'cate1')
		incident = build(:incident, location: nil, cate_id: 1)
		incident.valid?
		expect(incident.errors[:location]).to include("can't be blank")
	end

	it "is invalid without a severity" do
		create(:cate, cate_name: 'cate1')
		incident = build(:incident, severity: nil, cate_id: 1)
		incident.valid?
		expect(incident.errors[:severity]).to include("can't be blank")
	end

	it "is invalid without a cate_id" do
		incident = build(:incident, cate_id: nil)
		incident.valid?
		expect(incident.errors[:cate_id]).to include("can't be blank")
	end

	it "is invalid with a non-exist cate" do
	    create(:cate, cate_name: 'cate1')
	    incident = build(:incident, cate_id: 2)
	    incident.valid?
	    expect(incident.errors[:cate]).to include("can't be blank")
	end

	it "is invalid without a other_cate_description when select last cate" do
		cate1 = create(:cate, cate_name: 'cate1')
		cate2 = create(:cate, cate_name: 'other')
		incident = build(:incident, cate_id: cate2.id)
		incident.valid?
		expect(incident.errors[:other_cate_description]).to include("can't be blank")
	end

	it "is invalid without a reporter_id" do
		create(:cate, cate_name: 'cate1')
		incident = build(:incident, reporter_id: nil, cate_id: 1)
		incident.valid?
		expect(incident.errors[:reporter_id]).to include("can't be blank")
	end

	it "is invalid without a non-exist reporter" do	
		cate = create(:cate, cate_name: 'cate1')
		department = create(:department, department_name: 'department1')
	    group = create(:group, group_name: 'group1', department_id: department.id)
	    create(:person, user_name: 'fanying', group_id: group.id)
	    incident = build(:incident, reporter_id: 2, cate_id: cate.id)
		incident.valid?
		expect(incident.errors[:reporter]).to include("can't be blank")
	end

end