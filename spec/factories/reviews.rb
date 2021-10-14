FactoryBot.define do
  factory :review do
    # Main fields
    comment { Faker::Lorem.sentence }
    ratings { rand(0..10) }

    # Customers feedback for comment
    votes { rand(0..100) }
    spam { rand(0..100) }

    # Rating
    service_rating { rand(0..10) }
    access_rating { rand(0..10) }
    comfort_rating { rand(0..10) }
    specific_ratings { rand(0..10) }

    # Mention
    mention { { user: 1 } }

    trait :with_pothos do
      after(:create) do |review|
        create(:photo, review: review)
      end
    end
  end
end
