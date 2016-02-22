require 'rails_helper'

describe Department do

  it "should has many groups" do
    t = Department.reflect_on_association(:groups)
    expect(t.macro).to eq :has_many
  end

  it "is invalid without a department_name" do
    department = build(:department, department_name: nil)
    department.valid?
    expect(department.errors[:department_name]).to include("can't be blank")
  end

  it "is invalid with a duplicate department_name" do
    create(:department, department_name: 'department1')
    department = build(:department, department_name: 'department1')
    department.valid?
    expect(department.errors[:department_name]).to include("has already been taken")
  end  
   
end
