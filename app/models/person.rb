class Person < ActiveRecord::Base
  	# Include default devise modules. Others available are:
  	# :confirmable, :lockable, :timeoutable and :omniauthable
  	devise :database_authenticatable, :registerable#,
         #:recoverable, :rememberable, :trackable, :validatable


	belongs_to :group
	has_many :reporter, :class_name => "Incident", :foreign_key => :reporter_id
	has_many :assignee, :class_name => "Incident", :foreign_key => :assignee_id
	has_many :conversations, :foreign_key => :sender_id

	validates :last_name, :user_name, :phone, :email, :group_id, presence: true
	validates :group, presence: true
	validates :user_name, :email, uniqueness: true
	validates_format_of :phone, :with => /\A(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}\z/
	validates_format_of :email, :with => /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/
	#validates_format_of :password, :with => /\A(?=.*\d)(?=.*([a-z]|[A-Z]))([\x20-\x7E]){8,40}\z/
	#Password should contain atleast one integer.
	#Password should contain atleast one alphabet(either in downcase or upcase).
	#Password can have special characters from 20 to 7E ascii values.
	#Password should be minimum of 8 and maximum of 40 cahracters long.
	validate :second_phone_not_same_as_phone

	def second_phone_not_same_as_phone
		if phone.eql? second_phone
			errors.add(:second_phone, "cannot be same as phone!")
		end
	end
end
