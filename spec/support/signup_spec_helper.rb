module SignupSpecHelper
  def register_user(user_attributes)
    visit '/signup'
    within("#new_user") do
      fill_in 'user_name', :with => user_attributes[:name]
      fill_in 'user_email', :with => user_attributes[:email]
      fill_in 'user_password', :with => user_attributes[:password]
      fill_in 'user_password_confirmation', :with => user_attributes[:password_confirmation]
      click_button 'Sign up'
    end
  end
end

RSpec.configure do |config|
  config.include SignupSpecHelper, :type => :request
end
