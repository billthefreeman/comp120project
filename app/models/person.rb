class Person < ActiveRecord::Base
	belongs_to :group
	has_many :reporter, :class_name => "Incident", :foreign_key => :reporter_id
	has_many :assignee, :class_name => "Incident", :foreign_key => :assignee_id

	validates :last_name, :user_name, :phone, :email, :group_id, presence: true
	validates :group, presence: true
	validates :user_name, :email, uniqueness: true
	validates :phone, :numericality => true, :length => { :mininum => 6, :maximum => 15}
	validates_format_of :email, :with => /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/
	validate :second_phone_not_same_as_phone

	def second_phone_not_same_as_phone
		if phone.eql? second_phone
			errors.add(:second_phone, "cannot be same as phone!")
		end
	end
end
