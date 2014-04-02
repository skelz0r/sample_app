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
	
	it "should require a name" do
		build(:user,:name => "").should_not be_valid
	end
	
	it "should require an email address" do
    build(:user,:email => "").should_not be_valid
	end
	
	it "should reject names that are too long" do
		long_name = "a" * 51
    build(:user,:name => long_name).should_not be_valid
	end
	
	it "should accept valid email addresses" do
		addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
		addresses.each do |address|
      build(:user,:email => address).should be_valid
		end
	end
	
	it "should reject invalid email addresses" do
		addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
		addresses.each do |address|
      build(:user,:email => address).should_not be_valid
		end
	end
	
	it "should reject duplicate email addresses" do
    email = "lol@oki.fr"
    create(:user, email: email)
    build(:user, email: email).should_not be_valid
	end
	
	it "should reject email addresses identical up to case" do
    create(:user, :email => "aa@aa.aa")
		build(:user, :email => "AA@AA.AA").should_not be_valid
	end

	describe "password validations" do
		
		it "should require a password" do
			build(:user, :password => "", :password_confirmation => "").should_not be_valid
		end
		
		it "should require a matching password confirmation" do
			build(:user,:password_confirmation => "invalid").should_not be_valid
		end
		
		it "should reject short passwords" do
			short = "a" * 5
			build(:user, :password => short, :password_confirmation => short).should_not be_valid
		end
		
		it "should reject long passwords" do
			long = "a" * 41
			build(:user, :password => long, :password_confirmation => long).should_not be_valid
		end
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
