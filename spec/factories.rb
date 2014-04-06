# By using the symbol ':user', we get Factory Girl to simulate the User model.
FactoryGirl.define do 

  sequence :email do |n|
    "person#{n}@example.com"
  end

  factory :user do
    name "Michael Hartl"
    email 
    password "foobar"
    password_confirmation "foobar"
  end

  factory :micropost do
    content "MyString"
  end

end
