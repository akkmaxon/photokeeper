FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "email#{n}@example.com" }
    full_name Faker::Name.name
    password 'password'
    password_confirmation 'password'
  end

  factory :photo do
    title Faker::Lorem.sentence
    caption Faker::Lorem.paragraph
  end

  factory :album do
    title Faker::Lorem.word
  end

  factory :comment do
    body Faker::Lorem.paragraph
  end
end
