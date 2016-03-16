require 'grape'
require 'grape-swagger'
module IncidentV1
	module Rule
		module Entities

			class User < Grape::Entity
				expose :first_name, documentation: {type: "string", required: false}
				expose :last_name, documentation: {type: "string", required: true}
				expose :user_name, documentation: {type: "string", required: true}
				expose :phone, documentation: {type: "string", required: true}
				expose :second_phone, documentation: {type: "string", required: false}
				expose :email, documentation: {type: "string", required: true}
				expose :group_id, documentation: {type: "integer", required: true}
			end

			class Incident < Grape::Entity
				expose :location, documentation: {type: "String", required: false}
				expose :severity, documentation: {type: "Integer", required: true}
				expose :cate_id, documentation: {type: "Integer", required: true}
				expose :other_cate_description, documentation: {type: "String", required: true}
				expose :incident_description, documentation: {type: "String", required: false}
				expose :reporter_id, documentation: {type: "Integer", required: true}
			end
		end

		class API < Grape::API

			desc "List all Incidents"
			get '/incident/all' do
		        Incident.all
		    end

		    desc "List all Users"
		    get '/user/all' do
		        Person.all
		    end

			desc 'Get category by id'
			params do
				requires :id , type: Integer , desc: 'category_id'
			end
			get '/category/:id' do
				cate = Cate.where(:id => params[:id]).first
				if cate != nil
					{
						status: 200,
						message: "Category found",
						category: Cate.find(params[:id])
					}	
				else
					{
						status: 400,
						message: "Category can not find"
					}
				end
			end

			desc 'Get group by id'
			params do
				requires :id , type: Integer , desc: 'group_id'
			end
			get '/group/:id' do
				group = Group.where(:id => params[:id]).first
				if group != nil
					{
						status: 200,
						message: "Group found",
						group: Group.find(params[:id])
					}	
				else
					{
						status: 400,
						message: "Group can not find"
					}
				end
			end

			desc 'Get groups in a department by department name'
			params do
				requires :department_name , type: String , desc: 'department_name'
			end
			get '/department/groups_in_department' do
				department = Department.where(:department_name => params[:department_name]).first
				if department != nil
					{
						status: 200,
						message: "Groups incidents found for department",
						groups: department.groups
					}	
				else
					{ 
						status: 400,
						message: "Department can not find"
					}
				end
			end


			desc 'Get reported incidents by username'
			params do
				requires :username , type: String , desc: 'user_name'
			end
			get '/user/user_reported_incidents' do
				p = Person.where(:user_name => params[:username]).first
				if p != nil
					{
						status: 200,
						message: "Reported incidents found for user",
						incidents: p.reporter
					}	
				else
					{
						status: 400,
						message: "User can not find"
					}
				end
			end

			desc 'Get assigned incidents by username'
			params do
				requires :username , type: String , desc: 'user_name'
			end
			get '/user/user_assigned_incidents' do
				p = Person.where(:user_name => params[:username]).first
				if p != nil
					{
						status: 200,
						message: "Assigned incidents found for user",
						incidents: p.assignee
					}	
				else
					{
						status: 400,
						message: "User can not find"
					}
				end
			end

			desc 'Get incidents by id'
			params do
				requires :id , type: Integer , desc: 'incident_id'
			end
			get '/incident/:id' do
				incident = Incident.where(:id => params[:id]).first
				if incident != nil
					{
						status: 200,
						message: "Incident successfully found",
						incidents: Incident.where(:id => params[:id])
					}	
				else
					{
						status: 400,
						message: "Incident can not find"
					}
				end
			end

			desc 'Get incidents by severity'
			params do
				requires :severity , type: Integer , desc: 'incident_severity'
			end
			get '/incident/incident_severity' do
				incident = Incident.where(:severity => params[:severity]).first
				if incident != nil
					{
						status: 200,
						message: "Incident successfully found",
						incidents: Incident.where(:severity => params[:severity])
					}	
				else
					{
						status: 400,
						message: "Incident can not find"
					}
				end
			end

			desc 'Get incidents by category'
			params do
				requires :cate_id , type: Integer , desc: 'incident_category'
			end
			get '/incident/incident_cate_id' do
				incident = Incident.where(:cate_id => params[:cate_id]).first
				if incident != nil
					{
						status: 200,
						message: "Incident successfully found",
						incidents: Incident.where(:cate_id => params[:cate_id])
					}	
				else
					{
						status: 400,
						message: "Incident can not find"
					}
				end
			end


			desc 'User sign up' do
				success Entities::User
			end
			params do
				optional  :first_name,   type: String
			    requires  :last_name,    type: String
			    requires  :user_name,    type: String
			    requires  :phone,        type: String, regexp: /\A(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}\z/
			    optional  :second_phone, type: String, regexp: /\A(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}\z/
			    requires  :email,        type: String, regexp: /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/
			    requires  :group_id,     type: Integer
			    requires  :pw,           type: String, regexp: /\A(?=.*\d)(?=.*([a-z]|[A-Z]))([\x20-\x7E]){8,40}\z/
			end
			post '/user/new' do
				begin
					if (Person.where(:user_name => params[:user_name]).first != nil)
						return {
							status: 409,
							message: "User name already taken"
						}
					elsif (Person.where(:email => params[:email]).first != nil)
						return {
							status: 409,
							message: "Email already taken"
						}
					elsif(params[:phone] == params[:second_phone])
						return {
							status: 409,
							message: "Second phone cannot be same as phone"
						}
					elsif (Group.where(:id => params[:group_id]).first == nil)
						return {
							status: 409,
							message: "Invalid group id"
						}
					else
						Person.create!({
							:first_name => params[:first_name],
							:last_name => params[:last_name],
							:user_name => params[:user_name],
							:phone => params[:phone],
							:second_phone => params[:second_phone],
							:email => params[:email],
							:group_id => params[:group_id],
						    :pw => params[:pw]
						}) 

						return {
							status: 200,
							message: "User successfully created",
							user: {:first_name => params[:first_name],
							:last_name => params[:last_name],
							:user_name => params[:user_name],
							:phone => params[:phone],
							:second_phone => params[:second_phone],
							:email => params[:email],
							:group_id => params[:group_id]}		
						}
					end
				end
			end


			desc 'Create incident' do
				success Entities::Incident
			end
			params do
				requires  :location,               type: String
			    requires  :severity,               type: Integer
			    requires  :cate_id,        		   type: Integer
			    optional  :other_cate_description, type: String
			    optional  :incident_description,   type: String
			    requires  :reporter_id,            type: Integer
			end
			post '/incident/new' do
				begin
					if (params[:severity] > 5 or params[:severity] < 1)
						return {
							status: 409,
							message: "Invalid severity"
						}
					elsif (Cate.where(:id => params[:cate_id]).first == nil)
						return {
							status: 409,
							message: "Invalid category id"
						}
					elsif (Cate.find(params[:cate_id]) == Cate.last && params[:other_cate_description] == nil)
						return {
							status: 409,
							message: "Unknown category must have a category description"
						}	
					elsif (Person.where(:id => params[:reporter_id]).first == nil)
						return {
							status: 409,
							message: "Invalid reporter id"
						}
					else 
						incident = Incident.new
						incident.location = params[:location]
						incident.severity = params[:severity]
						incident.cate_id  = params[:cate_id]
						incident.other_cate_description = params[:other_cate_description]
						incident.incident_description = params[:incident_description]
						incident.reporter_id = params[:reporter_id]
        				incident.save			 
						return {
							status: 200,
							message: "Incident successfully created",
							incident: {:location => params[:location],
							:severity => params[:severity],
							:cate_id => params[:cate_id],
							:other_cate_description => params[:other_cate_description],
							:incident_description => params[:incident_description],
							:reporter_id => params[:reporter_id]}		
						}
					end
				end
			end

			desc "Update an user information"
			params do
				requires  :id,           type: String
				optional  :first_name,   type: String
			    requires  :last_name,    type: String
			    requires  :user_name,    type: String
			    requires  :phone,        type: String, regexp: /\A(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}\z/
			    optional  :second_phone, type: String, regexp: /\A(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}\z/
			    requires  :email,        type: String, regexp: /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/
			    requires  :group_id,     type: Integer
			    requires  :pw,           type: String, regexp: /\A(?=.*\d)(?=.*([a-z]|[A-Z]))([\x20-\x7E]){8,40}\z/
			end
			put '/user/:id' do
				if (Person.where(:user_name => params[:user_name]).first != nil)
						return {
							status: 409,
							message: "User name already taken"
					}
				elsif (Person.where(:email => params[:email]).first != nil)
					return {
						status: 409,
						message: "Email already taken"
					}
				elsif(params[:phone] == params[:second_phone])
					return {
						status: 409,
						message: "Second phone cannot be same as phone"
					}
				elsif (Group.where(:id => params[:group_id]).first == nil)
					return {
						status: 409,
						message: "Invalid group id"
					}
				else
					Person.find(params[:id]).update({
				    	:first_name => params[:first_name],
						:last_name => params[:last_name],
						:user_name => params[:user_name],
						:phone => params[:phone],
						:second_phone => params[:second_phone],
						:email => params[:email],
						:group_id => params[:group_id],
					    :pw => params[:pw]
				  	})
				  	return {
						status: 200,
						message: "User successfully updated",
						user: {:first_name => params[:first_name],
						:last_name => params[:last_name],
						:user_name => params[:user_name],
						:phone => params[:phone],
						:second_phone => params[:second_phone],
						:email => params[:email],
						:group_id => params[:group_id]	
					}
				end
			end

			desc "Update an incident information"
			params do
				requires  :id,                     type: String
				requires  :location,               type: String
			    requires  :severity,               type: Integer
			    requires  :cate_id,        		   type: Integer
			    optional  :other_cate_description, type: String
			    optional  :incident_description,   type: String
			    requires  :reporter_id,            type: Integer
			end
			put '/incident/:id' do
				if (params[:severity] > 5 or params[:severity] < 1)
						return {
							status: 409,
							message: "Invalid severity"
						}
				elsif (Cate.where(:id => params[:cate_id]).first == nil)
					return {
						status: 409,
						message: "Invalid category id"
					}
				elsif (Cate.find(params[:cate_id]) == Cate.last && params[:other_cate_description] == nil)
					return {
						status: 409,
						message: "Unknown category must have a category description"
					}	
				elsif (Person.where(:id => params[:reporter_id]).first == nil)
					return {
						status: 409,
						message: "Invalid reporter id"
					}
				else 
					Incident.find(params[:id]).update({
				    	:location => params[:location],
						:severity => params[:severity],
						:cate_id => params[:cate_id],
						:other_cate_description => params[:other_cate_description],
						:incident_description => params[:incident_description],
						:reporter_id => params[:reporter_id]
				  	})
				  	return {
						status: 200,
						message: "User information successfully updated",
						incident: {:location => params[:location],
						:severity => params[:severity],
						:cate_id => params[:cate_id],
						:other_cate_description => params[:other_cate_description],
						:incident_description => params[:incident_description],
						:reporter_id => params[:reporter_id]}		
					}
				end
			end


			desc "delete an incident"
		    params do
		    	requires :id, type: Integer
		    end
		    delete '/incident/:id' do
		    	Incident.find(params[:id]).destroy!
	    	end
		end
	end

	class GrapeAPI < Grape::API
		before do
			header['Access-Control-Allow-Origin'] = header['Access-Control-Request-Method']='*'
		end
		format :json
		mount Rule::API
		add_swagger_documentation(
			base_path: "/v1",
			mount_path: '/doc',
			info: {
				title: 'Incident (API version 1)'
			},
			markdown: false,
			hiden_document_path: true,
			hide_format: true,
			include_base_url: true,
			api_version: '1.0'
		)
	end
end



