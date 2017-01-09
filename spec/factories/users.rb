FactoryGirl.define do

  sequence :email do |n|
    "test#{n}@example.com"
  end

  factory :user do
    first_name "Jon"
    last_name "Snow"
    email { generate :email }
    password "foobar"
    password_confirmation "foobar"
  end

  factory :admin, class: "AdminUser" do
    first_name "Admin"
    last_name "User"
    email "admin@user.com"
    password "foobar"
    password_confirmation "foobar"
  end
end
