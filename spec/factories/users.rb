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
    phone '5129949730'
  end

  factory :admin, class: "AdminUser" do
    first_name "Admin"
    last_name "User"
    email "admin@user.com"
    password "foobar"
    password_confirmation "foobar"
    phone '5129949730'
  end

  factory :non_auth_user, class: "User" do
    first_name "Non"
    last_name "Authorized"
    email { generate :email }
    password "foobar"
    password_confirmation "foobar"
    phone '5129949730'
  end
end
