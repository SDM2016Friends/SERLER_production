#Create fixtures with FactoryGirl
require 'faker'
FactoryGirl.define do
  factory :user do |f|
    email { Faker::Internet.email  }
    password "password"
    password_confirmation "password"
  end
end
