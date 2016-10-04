#Create fixtures with FactoryGirl
require 'faker'
FactoryGirl.define do
  factory :user do |f|
    email { Faker::Internet.email  }
    password "password"
    password_confirmation "password"
    first_name { Faker::Name.name }
    middle_name { Faker::Name.name }
    last_name { Faker::Name.name }
  end
end
