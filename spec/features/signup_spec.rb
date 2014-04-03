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
    expect(page).to have_content 'Success'
  end
end
