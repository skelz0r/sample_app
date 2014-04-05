require 'spec_helper'
include SigninSpecHelper

describe "the login process", :type => :feature do
  let(:user) { create(:user) }

  it "logs me in" do
    signin_user

    expect_signin_success
  end

  it "rejects wrong email" do
    user.email = "a.a@a.a"

    signin_user

    expect_signin_failure
  end

  it "rejects wrong password" do
    user.password = "trolololo lolo lolo"

    signin_user

    expect_signin_failure
  end

end
