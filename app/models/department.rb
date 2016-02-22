class Department < ActiveRecord::Base
  has_many :groups
  validates :department_name, uniqueness: true, presence: true
end
