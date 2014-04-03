# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  encrypted_password :string(255)
#  salt               :string(255)
#

require 'spec_helper'
describe User do

  it "should create a new instance given valid attributes" do
    build(:user).should be_valid
  end

  it { should validate_presence_of(:name) }

  it { should validate_presence_of(:email) }

  it { should ensure_length_of(:name).is_at_most(50) }

  it { should allow_value('user@foo.com', 'THE_USER@foo.bar.org', 'first.last@foo.jp').for(:email) }

  it { should_not allow_value('user@foo,com', 'user_at_foo.org', 'example.user@foo.').for(:email) }

  it { should validate_uniqueness_of(:email) }

  describe "password validations" do

    it { should validate_presence_of(:password) }

    it do
          should validate_confirmation_of(:password).
                  with_message('Please re-enter your password')
    end

    it { should ensure_length_of(:password).is_at_least(6).is_at_most(40) }
  end

  describe "password encryption" do

    let(:user) { create(:user) }

    it "should have an encrypted password attribute" do
      user.should respond_to(:encrypted_password)
    end

    it "should set the encrypted password" do
      user.encrypted_password.should_not be_blank
    end

    describe "has_password? method" do

      it "should be true if the passwords match" do
        user.has_password?(user.password).should be_true
      end

      it "should be false if the passwords don't match" do
        user.has_password?("invalid").should be_false
      end
    end

    describe "authenticate method" do

      it "should return nil on email/password mismatch" do
        User.authenticate(user.email, "wrongpass").should be_nil
      end

      it "should return nil for an email address with no user" do
        User.authenticate("bar@foo.com", user.password).should be_nil
      end

      it "should return the user on email/password match" do
        User.authenticate(user.email, user.password).should == user
      end
    end
  end
end
