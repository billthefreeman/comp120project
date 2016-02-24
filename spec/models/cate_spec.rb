require 'rails_helper'

describe Cate do

  it "is invalid without a cate_name" do
    cate = build(:cate, cate_name: nil)
    cate.valid?
    expect(cate.errors[:cate_name]).to include("can't be blank")
  end

  it "is invalid with a duplicate cate_name" do
    create(:cate, cate_name: 'cate1')
    cate = build(:cate, cate_name: 'cate1')
    cate.valid?
    expect(cate.errors[:cate_name]).to include("has already been taken")
  end  

end
