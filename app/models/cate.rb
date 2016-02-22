class Cate < ActiveRecord::Base
  has_many :incidents
  validates :cate_name, uniqueness: true, presence: true
end
