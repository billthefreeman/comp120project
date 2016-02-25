require 'rails_helper'

Capybara.app_host = "http://localhost:3000"
#timeline page
describe "incidents/index.html.erb", :type => :feature do 
  describe "new incident page" do
    before :each do
	  status = create(:status, status_name: 'reported')
	  cate1 = create(:cate, cate_name: 'cate1')
	  cate2 = create(:cate, cate_name: 'cate2')
	  department = create(:department, department_name: 'department1')
	  group = create(:group, group_name: 'group1', department_id: department.id)
	  reporter = create(:person, user_name: 'fanying', group_id: group.id)
	  @incident = create(:incident, 
						  location: 'haliigan',
						  cate_id: cate1.id, 
						  severity: 1,
						  status_id: status.id,
						  reporter_id:reporter.id)
	   end

  	it "has new button" do
      visit'/incidents'
      expect(page).to have_content 'New'
    end

    it "new button jump to incidents/new" do
      visit'/incidents'
      click_on('New') 
      expect(page).to have_content 'Incident reporting system'
    end

    it "has show button" do
      visit'/incidents'
      expect(page).to have_content 'Show'
    end

    it "show button jump to show incident page" do
      visit'/incidents'
      click_on('Show')
      expect(page).to have_content 'Assignee'
    end

    it "has edit button" do
      visit'/incidents'
      expect(page).to have_content 'Edit'
    end

    it "show button jump to show incident page" do
      visit'/incidents'
      click_on('Edit')
      expect(page).to have_content 'Incident reporting system'
    end

  end
end