require 'spec_helper'
include SigninSpecHelper

describe SessionsController do
  render_views

  describe "GET 'new'" do
    it "should be successful" do
      get :new
      response.should be_success
    end

    it "should have the right title" do
      get :new
      response.should have_selector("title", :content => "Sign in")
    end
  end

  describe "POST 'create'" do
    describe "with valid email and password" do
      let(:user){ create(:user)}

      it "should have a cookie of the user" do
        attr = { :email => user.email, :password => user.password }

        post :create, :session => attr

        session[:remember_token].should_not be_blank
        session[:remember_token].should_not == [nil, nil]
      end
    end
  end
end
