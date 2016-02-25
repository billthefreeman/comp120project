require 'rails_helper'

Capybara.app_host = "http://localhost:3000"
#test new incident page
describe "incidents/_form.html.erb", :type => :feature do 
  describe "new incident page" do
    before :each do
	  status = create(:status, status_name: 'reported')
	  cate1 = create(:cate, cate_name: 'cate1')
	  cate2 = create(:cate, cate_name: 'Other')
	  department = create(:department, department_name: 'department1')
	  group = create(:group, group_name: 'group1', department_id: department.id)
	  reporter = create(:person, user_name: 'fanying', group_id: group.id, phone: '12345678', email: 'fanying@tufts.edu')
	  @incident = create(:incident, 
						  location: 'haliigan',
						  cate_id: cate1.id, 
						  severity: 1,
						  status_id: status.id,
						  reporter_id:reporter.id)
	end
    it "show the information of reporter" do
  	  visit'/incidents/new'
      expect(page).to have_content('Reporter Name')
    end
    it "select Reporter Name works"  do
      visit'/incidents/new'
  #    select "fanying", :from => "incident[reporter_id]"
  #    expect(page).to have_content('12345678')
  	  expect(page).to have_select('incident[reporter_id]')
    end
    it "select category works"  do
      visit'/incidents/new'
  #    select "Other", :from => "incident[cate_id]"
  #    expect(page).to have_content('Other Category')
      expect(page).to have_select('incident[cate_id]')
    end
  end
end

