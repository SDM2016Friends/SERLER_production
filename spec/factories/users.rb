#Create fixtures with FactoryGirl
require 'faker'
FactoryGirl.define do
  factory :user do |f|
    f.email { Faker::Internet.email }
    f.password { Faker::Internet.password(8) }
    f.first_name {Faker::Name.name}
    f.middle_name {Faker::Name.name}
    f.last_name {Faker::Name.name}
  end
end
