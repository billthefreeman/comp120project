class Status < ActiveRecord::Base
	validates :status_name, uniqueness: true, presence: true
end
