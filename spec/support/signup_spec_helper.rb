module SignupSpecHelper
  def register_user(user_attributes)
    visit signup_path
    within("#new_user") do
      fill_in 'user_name', :with => user_attributes[:name]
      fill_in 'user_email', :with => user_attributes[:email]
      fill_in 'user_password', :with => user_attributes[:password]
      fill_in 'user_password_confirmation', :with => user_attributes[:password_confirmation]
      click_button 'Sign up'
    end
  end

  def expect_success
    expect(page).to have_css '.notice'
    current_path.should == root_path
  end

  def expect_failure
    expect(page).to have_css '.alert'
    current_path.should == signup_path
  end

end

RSpec.configure do |config|
  config.include SignupSpecHelper, :type => :request
end
