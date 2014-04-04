require 'spec_helper'
include SignupSpecHelper

describe "the signin process", :type => :feature do
  let(:user) { attributes_for(:user) }

  it "signs me in" do
    register_user(user) 

    expect(page).to have_content 'successful'
    current_path.should == '/'
  end

  it "should reject empty names" do
    user[:name] = ""

    register_user(user)

    expect(page).to have_content 'Error'
    current_path.should == '/signup'
  end

  it "should reject long names" do
    user[:name] = "a" * 51

    register_user(user)

    expect(page).to have_content 'Error'
    current_path.should == '/signup'
  end

  it "should reject empty emails" do
    user[:email] = ""

    register_user(user)

    expect(page).to have_content 'Error'
    current_path.should == '/signup'
  end 

  it "should reject invalid emails" do
    user[:email] = "user@foo,com"

    register_user(user)

    expect(page).to have_content 'Error'
    current_path.should == '/signup'
  end

  context "When a user tries to signup with an email already in use" do
    before (:each) do
      create(:user,user)
    end
    it "should reject duplicated emails" do
      register_user(user)

      expect(page).to have_content 'Error'
      current_path.should == '/signup'
    end
  end

  it "should reject empty password" do
    user[:password] = ""

    register_user(user)

    expect(page).to have_content 'Error'
    current_path.should == '/signup'
  end

  it "should reject mismatched passwords" do
    user[:password] = "a9"

    register_user(user)

    expect(page).to have_content 'Error'
    current_path.should == '/signup'
  end

  it "should reject emails with wrong size" do
    user[:password] = "a" * 5
    user[:password_confirmation] = "a" * 5

    register_user(user)

    expect(page).to have_content 'Error'
    current_path.should == '/signup'
  end
end
