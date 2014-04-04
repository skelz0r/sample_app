require 'spec_helper'
describe "the signin process", :type => :feature do
  let(:user) { build(:user) }

  it "signs me in" do
    visit '/signup'
    within("#new_user") do
      fill_in 'user_name', :with => user.name
      fill_in 'user_email', :with => user.email
      fill_in 'user_password', :with => user.password
      fill_in 'user_password_confirmation', :with => user.password_confirmation
    end
    click_button 'Sign up'
    expect(page).to have_content 'successful'
    current_path.should == '/'
  end
  it "should reject empty names" do
    visit '/signup'
    within("#new_user") do
      fill_in 'user_name', :with =>""
      fill_in 'user_email', :with => user.email
      fill_in 'user_password', :with => user.password
      fill_in 'user_password_confirmation', :with => user.password_confirmation
    end
    click_button 'Sign up'
    expect(page).to have_content 'Error'
    current_path.should == '/signup'
  end
  it "should reject long names" do
    visit '/signup'
    within("#new_user") do
      fill_in 'user_name', :with =>"a" * 51
      fill_in 'user_email', :with => user.email
      fill_in 'user_password', :with => user.password
      fill_in 'user_password_confirmation', :with => user.password_confirmation
    end
    click_button 'Sign up'
    expect(page).to have_content 'Error'
     current_path.should == '/signup'
  end
  it "should reject empty emails" do
    visit '/signup'
    within("#new_user") do
      fill_in 'user_name', :with => user.name
      fill_in 'user_email', :with => ""
      fill_in 'user_password', :with => user.password
      fill_in 'user_password_confirmation', :with => user.password_confirmation
    end
    click_button 'Sign up'
    expect(page).to have_content 'Error'
     current_path.should == '/signup'
  end 
  it "should reject invalid emails" do
    visit '/signup'
    adresses =  %w[user@foo,com user_at_foo.org example.user@foo.]
    adresses.each{ |email|
      within("#new_user") do
        fill_in 'user_name', :with => user.name
        fill_in 'user_email', :with => email
        fill_in 'user_password', :with => user.password
        fill_in 'user_password_confirmation', :with => user.password_confirmation
      end
      click_button 'Sign up'
      expect(page).to have_content 'Error'
       current_path.should == '/signup'
    }
  end
  it "should reject duplicated emails" do
    visit '/signup'
    create(:user, name: "totoh the fooh", email: "foo@foo.foo", password: "foobar", password_confirmation: "foobar")
    user2 = build(:user, name: "totoh the fooh", email: "foo@foo.foo", password: "foobar", password_confirmation: "foobar")
    within("#new_user") do
      fill_in 'user_name', :with => user2.name
      fill_in 'user_email', :with => user2.email
      fill_in 'user_password', :with => user2.password
      fill_in 'user_password_confirmation', :with => user2.password_confirmation
    end
    click_button 'Sign up'
    expect(page).to have_content 'Error'
     current_path.should == '/signup'
  end
  it "should reject empty password" do
    visit '/signup'
    within("#new_user") do
      fill_in 'user_name', :with => user.name
      fill_in 'user_email', :with => user.email
      fill_in 'user_password', :with => ""
      fill_in 'user_password_confirmation', :with => user.password_confirmation
    end
    click_button 'Sign up'
    expect(page).to have_content 'Error'
     current_path.should == '/signup'
  end
  it "should reject mismatched passwords" do
    visit '/signup'
    within("#new_user") do
      fill_in 'user_name', :with => user.name
      fill_in 'user_email', :with => user.email
      fill_in 'user_password', :with => user.email
      fill_in 'user_password_confirmation', :with => user.password_confirmation
    end
    click_button 'Sign up'
    expect(page).to have_content 'Error'
     current_path.should == '/signup'
  end
  it "should reject mismatched passwords" do
    visit '/signup'
    within("#new_user") do
      fill_in 'user_name', :with => user.name
      fill_in 'user_email', :with => user.email
      fill_in 'user_password', :with => user.email
      fill_in 'user_password_confirmation', :with => user.password_confirmation
    end
    click_button 'Sign up'
    expect(page).to have_content 'Error'
     current_path.should == '/signup'
  end
  it "should reject emails with wrong size" do
    visit '/signup'
    passwd = ["a"*5, "a"*41]
    passwd.each{ |password|
      within("#new_user") do
        fill_in 'user_name', :with => user.name
        fill_in 'user_email', :with => user.email
        fill_in 'user_password', :with => password
        fill_in 'user_password_confirmation', :with => password
      end
      click_button 'Sign up'
      expect(page).to have_content 'Error'
       current_path.should == '/signup'
    }
  end
end
