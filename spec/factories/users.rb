FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    sequence(:email) {|n| "#{n}_#{Faker::Internet.email}" }
    password { Faker::Internet.password(min_length: 8, max_length: 32, mix_case: false, special_characters: false) }
    profile { Faker::Lorem.sentences }
    avatar { Faker::Avatar.image }
  end
end
