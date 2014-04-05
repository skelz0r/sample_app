module SigninSpecHelper

  def signin_user
    visit signin_path
    within("#new_session") do
      fill_in 'session_email', :with => user.email
      fill_in 'session_password', :with => user.password
      click_button 'Sign In'
    end
  end

  def expect_success
    expect(page).to have_css '.notice'
    current_path.should == root_page
  end

  def expect_failure
    expect(page).to have_css '.alert'
    current_path.should == signin_path
  end

end

RSpec.configure do |config|
  config.include SigninSpecHelper, :type => :request
end
