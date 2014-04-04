require 'spec_helper'
include SignupSpecHelper

describe "the signin process", :type => :feature do
  let(:user_attributes) { attributes_for(:user) }

  it "signs me in" do
    register_user(user_attributes) 

    expect(page).to have_content 'successful'
    current_path.should == root_path
  end

  it "should reject empty names" do
    user_attributes[:name] = ""

    register_user(user_attributes)

    expect(page).to have_content 'Error'
    current_path.should == signup_path
  end

  it "should reject long names" do
    user_attributes[:name] = "a" * 51

    register_user(user_attributes)

    expect(page).to have_content 'Error'
    current_path.should == signup_path
  end

  it "should reject empty emails" do
    user_attributes[:email] = ""

    register_user(user_attributes)

    expect(page).to have_content 'Error'
    current_path.should == signup_path
  end 

  it "should reject invalid emails" do
    user_attributes[:email] = "user@foo,com"

    register_user(user_attributes)

    expect(page).to have_content 'Error'
    current_path.should == signup_path
  end

  context "When a user tries to signup with an email already in use" do
    before (:each) do
      create(:user,user_attributes)
    end
    it "should reject duplicated emails" do
      register_user(user_attributes)

      expect(page).to have_content 'Error'
      current_path.should == signup_path
    end
  end

  it "should reject empty password" do
    user_attributes[:password] = ""

    register_user(user_attributes)

    expect(page).to have_content 'Error'
    current_path.should == signup_path
  end

  it "should reject mismatched passwords" do
    user_attributes[:password] = "a9"

    register_user(user_attributes)

    expect(page).to have_content 'Error'
    current_path.should == signup_path
  end

  it "should reject emails with wrong size" do
    user_attributes[:password] = "a" * 5
    user_attributes[:password_confirmation] = "a" * 5

    register_user(user_attributes)

    expect(page).to have_content 'Error'
    current_path.should == signup_path
  end
end
