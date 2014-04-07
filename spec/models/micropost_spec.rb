# == Schema Information
#
# Table name: microposts
#
#  id         :integer          not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Micropost do
  let(:user){create(:user)}

  it "should create a new instance given valid attributes" do
    build(:micropost).should be_valid
  end

  describe "user associations" do
    before do
      pending "GO SHOULDA, OKI?"
    end
    let(:micropost){user.microposts.create!(attributes_for(:micropost))}

    it "should have a user attribute" do
      micropost.should respond_to(:user)
    end

    it "should have the right associated user" do
      micropost.user_id.should == user.id
      micropost.user.should == user
    end
  end

  describe "validations" do
    before do
      pending "GO SHOULDA, OKI?"
    end

    it "should require a user id" do
      Micropost.new(attributes_for(:micropost)).should_not be_valid
    end
    it "should require nonblank content" do
      user.microposts.build(:content => " ").should_not be_valid
    end
    it "should reject long content" do
      user.microposts.build(:content => "a" * 141).should_not be_valid
    end
  end
end
