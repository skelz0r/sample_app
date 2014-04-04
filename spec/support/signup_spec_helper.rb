module SignupSpecHelper
  def register_user
    visit '/signup'
    within("#new_user") do
      fill_in 'user_name', :with => user[:name]
      fill_in 'user_email', :with => user[:email]
      fill_in 'user_password', :with => user[:password]
      fill_in 'user_password_confirmation', :with => user[:password_confirmation]
      click_button 'Sign up'
    end
  end
end

RSpec.configure do |config|
  config.include SignupSpecHelper, :type => :request
end
