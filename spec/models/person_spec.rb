require 'rails_helper'


describe Person do

	it "should belongs to group" do
	    t = Person.reflect_on_association(:group)
	    expect(t.macro).to eq :belongs_to
  	end

	it "is invalid without a last_name" do
		person = build(:person, last_name: nil)
		person.valid?
		expect(person.errors[:last_name]).to include("can't be blank")
	end

	it "is invalid without a user_name" do
		person = build(:person, user_name: nil)
		person.valid?
		expect(person.errors[:user_name]).to include("can't be blank")
	end

	it "is invalid without a phone" do
		person = build(:person, phone: nil)
		person.valid?
		expect(person.errors[:phone]).to include("can't be blank")
	end

	it "is invalid without a email" do
		person = build(:person, email: nil)
		person.valid?
		expect(person.errors[:email]).to include("can't be blank")
	end

	
	it "is invalid without a group_id" do
		person = build(:person, group_id: nil)
		person.valid?
		expect(person.errors[:group_id]).to include("can't be blank")
	end

	it "is invalid with a duplicate user_name" do
		department = create(:department, department_name: 'department1')
	    group = create(:group, group_name: 'group1', department_id: department.id)
	    create(:person, user_name: 'fanying', group_id: group.id)
	    person = build(:person, user_name: 'fanying', group_id: group.id)
		person.valid?
		expect(person.errors[:user_name]).to include("has already been taken") 
	end

	it "is invalid with a duplicate email" do
		department = create(:department, department_name: 'department1')
	    group = create(:group, group_name: 'group1', department_id: department.id)
	    create(:person, user_name: 'fanying', email: 'fye@tufts.edu', group_id: group.id)
	    person = build(:person, user_name: 'yan',email: 'fye@tufts.edu', group_id: group.id)
		person.valid?
		expect(person.errors[:email]).to include("has already been taken") 		
	end

	it "is invalid with a invalid phone" do 
		person = build(:person, phone: 'abc')
		expect(person).not_to be_valid
	end

	it "is invalid with a invalid email" do 
		person = build(:person, email: 'abc')
		expect(person).not_to be_valid
	end

	it "is invalid with a invalid group_id" do 
		department = create(:department, department_name: 'department1')
	    group = create(:group, group_name: 'group1', department_id: department.id)
	    person = build(:person, user_name: 'yan',email: 'yhuo@tufts.edu', group_id: 2)
		person.valid?
	    expect(person.errors[:group]).to include("can't be blank")
	end

	it "does not allow second phone to be same as phone" do
		person = build(:person, phone: '234567',second_phone: '234567')
		person.valid?
		expect(person.errors[:second_phone]).to include("cannot be same as phone!")
	end

end