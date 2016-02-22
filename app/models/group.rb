class Group < ActiveRecord::Base
  has_many :people
  belongs_to :department
  validates :group_name, uniqueness: true, presence: true
  validates :department_id, presence: true
  validates :department, presence: true
end
