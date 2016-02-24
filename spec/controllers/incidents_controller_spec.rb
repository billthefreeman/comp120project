require 'rails_helper'

describe IncidentsController, :type => :controller do

	describe 'GET #index' do
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

	    it "assigns the requested incident to @incident" do
	    	
			get :index
			expect(assigns(:incidents)).to eq([@incident])
	    end
	    it "renders the index template" do
			get :index
			expect(response).to render_template("index")
	    end
	end

	describe 'GET #show' do
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

    	it "assigns the requested incident to @incident" do
      		get :show, id: @incident
      		expect(assigns(:incident)).to eq @incident
    	end

	    it "renders the :show template" do
	 		get :show, id: @incident
	 		expect(response).to render_template :show
	    end
	end

	describe 'GET #edit' do
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

    	it "assigns the requested incident to @incident" do
			get :edit, id: @incident
			expect(assigns(:incident)).to eq @incident
    	end
    	it "renders the :edit template" do 
			get :edit, id: @incident
			expect(response).to render_template :edit
    	end
	end

	describe 'GET #new' do
	    it "assigns a new Incident to @Incident" do
	      	get :new
	      	expect(assigns(:incident)).to be_a_new(Incident)
	    end

	    it "renders the :new template" do
	      	get :new
	      	expect(response).to render_template :new
	    end
	end

	describe "POST #create" do
		context "with valid attributes" do
			it "saves the new incident in the database" do
				status = create(:status, status_name: 'reported')
				cate1 = create(:cate, cate_name: 'cate1')
		    	cate2 = create(:cate, cate_name: 'cate2')
				department = create(:department, department_name: 'department1')
			    group = create(:group, group_name: 'group1', department_id: department.id)
			    reporter = create(:person, user_name: 'fanying', group_id: group.id)
				expect{
	        		post :create, 
	        			incident: build(:incident,
	        					  location: 'anderson',
			        			  reporter_id: reporter.id, 
			        			  cate_id: cate1.id,
			        			  status_id: status.id,
			        			  severity: 5
			        			  ).attributes
	      		}.to change(Incident, :count).by(1)
	      	end

	  		it "redirects to incident#index" do
	  			status = create(:status, status_name: 'reported')
				cate1 = create(:cate, cate_name: 'cate1')
		    	cate2 = create(:cate, cate_name: 'cate2')
				department = create(:department, department_name: 'department1')
			    group = create(:group, group_name: 'group1', department_id: department.id)
			    reporter = create(:person, user_name: 'fanying', group_id: group.id)
	  			post :create, 
	        			incident: { 
							   :location => 'Library2',
							   :cate_id => cate1.id, 
							   :severity => 4,
							   :status_id => status.id,
							   :reporter_id => reporter.id}
	  			expect(response).to redirect_to('/incidents')
	  		end
	  	end

	  	context "without valid attributes" do
			it "missing location, does not save the new incident in the database" do
				expect{
	        		post :create, incident: attributes_for(:invalid_incident_no_location)
	      		}.to_not change(Incident, :count)
	      	end
	      	it "missing severity, does not save the new incident in the database" do
				expect{
	        		post :create, incident: attributes_for(:invalid_incident_no_severity)
	      		}.to_not change(Incident, :count)
	      	end
	      	it "missing cate, does not save the new incident in the database" do
				expect{
	        		post :create, incident: attributes_for(:invalid_incident_no_cate)
	      		}.to_not change(Incident, :count)
	      	end
	  		
	  	end
	end

	describe 'PATCH #update' do
		before :each do
			@status = create(:status, status_name: 'reported')
			@status2 = create(:status, status_name: 'processing')
			@cate1 = create(:cate, cate_name: 'cate1')
	    	@cate2 = create(:cate, cate_name: 'cate2')
			department = create(:department, department_name: 'department1')
		    group = create(:group, group_name: 'group1', department_id: department.id)
		    @reporter = create(:person, user_name: 'fanying', group_id: group.id)
			@incident = create(:incident, 
							   location: 'Halligan',
							   cate_id: @cate1.id, 
							   severity: 1,
							   status_id: @status.id,
							   reporter_id:@reporter.id)
		end

		context "valid attributes" do

			it "locates the requested @incident" do
				patch :update, id: @incident, incident: @incident.attributes
				expect(assigns(:incident)).to eq(@incident)
			end


			it "changes @incidents's attributes (location, severity, cate)" do
				patch :update, id: @incident,
        			incident: { 
							   :location => 'Library2',
							   :cate_id => @cate1.id, 
							   :severity => 4,
							   :status_id => @status2.id,
							   :reporter_id => @reporter.id}
	      		@incident.reload
	      		expect(@incident.location).to eq('Library2')
	      		expect(@incident.status_id).to eq(@status2.id)
	      		expect(@incident.severity).to eq(4)
	      		
			end

			it "redirects to the incidents list" do
				patch :update, id: @incident, incident: @incident.attributes
				expect(response).to redirect_to ('/incidents')
			end 
		end

		context "with invalid attributes" do
			it "without a valid location, does not change the incident's attributes" do
        		patch :update, id: @incident,
          			incident: attributes_for(:incident,
          				location: nil,
          				severity: 2,
          				cate_id: 2)
          		@incident.reload
        		expect(@incident.location).to eq('Halligan')
  	     		expect(@incident.severity).to_not eq(2)
  	    		expect(@incident.cate_id).to_not eq(@cate2.id)
  	    	end

  	    	it "without a valid severity, does not change the incident's attributes" do
        		patch :update, id: @incident,
          			incident: attributes_for(:incident,
          				location: 'Library',
          				severity: nil,
          				cate_id: 2)
          		@incident.reload
        		expect(@incident.location).to_not eq('Library')
  	     		expect(@incident.severity).to eq(1)
  	    		expect(@incident.cate_id).to_not eq(2)
  	    	end

  	    	it "without a valid cate, does not change the incident's attributes" do
        		patch :update, id: @incident,
          			incident: attributes_for(:incident,
          				location: 'Library',
          				severity: 2,
          				cate_id: nil)
          		@incident.reload
        		expect(@incident.location).to_not eq('Library')
  	     		expect(@incident.severity).to_not eq(2)
  	    		expect(@incident.cate_id).to eq(@cate1.id)
  	    	end
		end
	end

end