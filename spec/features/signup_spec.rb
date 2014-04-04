require 'spec_helper'
include SignupSpecHelper

describe "the signin process", :type => :feature do
  let(:user) { attributes_for(:user) }

  it "signs me in" do
    register_user 

    expect(page).to have_content 'successful'
    current_path.should == '/'
  end

  it "should reject empty names" do
    user[:name] = ""

    register_user 

    expect(page).to have_content 'Error'
    current_path.should == '/signup'
  end

  it "should reject long names" do
    user[:name] = "a" * 51

    register_user 

    expect(page).to have_content 'Error'
    current_path.should == '/signup'
  end

  it "should reject empty emails" do
    user[:email] = ""

    register_user 

    expect(page).to have_content 'Error'
    current_path.should == '/signup'
  end 

  it "should reject invalid emails" do
    user[:email] = "user@foo,com"

    register_user 

    expect(page).to have_content 'Error'
    current_path.should == '/signup'
  end

  it "should reject duplicated emails" do
    visit '/signup'
    user = create(:user, name: "totoh the fooh", email: "foo@foo.foo", password: "foobar", password_confirmation: "foobar")
    user_with_same_email = build(:user, email: user.email)

    within("#new_user") do
      fill_in 'user_name', :with => user_with_same_email.name
      fill_in 'user_email', :with => user_with_same_email.email
      fill_in 'user_password', :with => user_with_same_email.password
      fill_in 'user_password_confirmation', :with => user_with_same_email.password_confirmation
      click_button 'Sign up'
    end

    expect(page).to have_content 'Error'
    current_path.should == '/signup'
  end

  it "should reject empty password" do
    user[:password] = ""

    register_user 

    expect(page).to have_content 'Error'
    current_path.should == '/signup'
  end

  it "should reject mismatched passwords" do
    user[:password] = "a9"

    register_user 

    expect(page).to have_content 'Error'
    current_path.should == '/signup'
  end

  it "should reject emails with wrong size" do
    user[:password] = "a" * 5
    user[:password_confirmation] = "a" * 5

    register_user 

    expect(page).to have_content 'Error'
    current_path.should == '/signup'
  end
end
