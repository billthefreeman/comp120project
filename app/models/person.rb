class Person < ActiveRecord::Base
belongs_to :group
has_many :reporter, :class_name => "Incident", :foreign_key => :reporter_id
has_many :assignee, :class_name => "Incident", :foreign_key => :assignee_id
end
