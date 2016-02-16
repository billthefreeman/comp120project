class Group < ActiveRecord::Base
  has_many :people
  belongs_to :department
end
