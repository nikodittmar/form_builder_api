require 'examples.rb'

FactoryBot.define do
    factory :user do
        username { Faker::Internet.unique.username }
        email { Faker::Internet.unique.email }
        password { Faker::Internet.password(mix_case: true) }
    end

    factory :form do
        user
        name { Faker::Lorem.sentence }
        title { Faker::Lorem.sentence }
        description { Faker::Lorem.paragraph }
        components { VALID_COMPONENTS }
        published { false }
    end
end