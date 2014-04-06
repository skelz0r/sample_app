require 'spec_helper'
describe UsersController do
  render_views

  describe "GET 'show'" do
    let(:user) { create(:user) }

    it "should be successful" do
      get :show, :id => user
      response.should be_success
    end

    it "should find the right user" do
      get :show, :id => user
      assigns(:user).should == user
    end
  end

  describe "GET 'new'" do

    it "should be successful" do
      get 'new'
      response.should be_success
    end

    it "should have the right title" do
      get 'new'
      response.should have_selector("title", :content => "Sign up")
    end
  end
  describe "POST 'create'" do
    describe "success" do
      it "should sign the user in" do
        post :create, :user => @attr
       pending " controller.should be_signed_in"
      end
    end
  end
end
