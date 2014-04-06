describe "Layout links" do
  
  describe "when not signed in" do
    it "should have a signin link" do
      visit root_path
      find_link('Sign in')[:href].should == signin_path
    end
  end

  describe "when signed in" do
    before(:each) do
      @user = create(:user)
      visit signin_path
      fill_in 'session_email', :with => @user.email
      fill_in 'session_password', :with => @user.password
      click_button 'Sign in'
    end

    it "should have a signout link" do
      visit root_path
     pending " find_link('Sign out')[:href].should == signout_path"
    end

    it "should have a profile link" do
      visit root_path
     pending " find_link(pqge)[:href].should == user_path(@user)"
    end

  end
end
