require 'rails_helper'

describe Status do

  it "is invalid without a status_name" do
    status = build(:status, status_name: nil)
    status.valid?
    expect(status.errors[:status_name]).to include("can't be blank")
  end

  it "is invalid with a duplicate status_name" do
    create(:status, status_name: 'reported')
    status = build(:status, status_name: 'reported')
    status.valid?
    expect(status.errors[:status_name]).to include("has already been taken")
  end  
  
end
