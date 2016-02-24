require 'rails_helper'

describe Group do

  it "should has many people" do
    t = Group.reflect_on_association(:people)
    expect(t.macro).to eq :has_many
  end

  it "should belongs to department" do
    t = Group.reflect_on_association(:department)
    expect(t.macro).to eq :belongs_to
  end

  it "is invalid without a group_name" do
    group = build(:group, group_name: nil)
    group.valid?
    expect(group.errors[:group_name]).to include("can't be blank")
  end

  it "is invalid without a department_id" do
    group = build(:group,
                  department_id: nil)
    group.valid?
    expect(group.errors[:department_id]).to include("can't be blank")
  end

  it "is invalid with a duplicate group_name" do
    department = create(:department, department_name: 'department1')
    create(:group, group_name: 'group1', department_id: department.id)
    group = build(:group, group_name: 'group1', department_id: department.id)
    group.valid?
    expect(group.errors[:group_name]).to include("has already been taken")
  end 

  it "is invalid with a non-exist department" do
    create(:department, department_name: 'department1')
    group = build(:group, group_name: 'group1', department_id: 2)
    group.valid?
    expect(group.errors[:department]).to include("can't be blank")
  end

end
