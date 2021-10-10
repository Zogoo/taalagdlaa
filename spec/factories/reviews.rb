FactoryBot.define do
  factory :review do
    comment { 'MyString' }
    rate { 1 }

    trait :with_pothos do
      after(:create) do |review|
        create(:photo, review: review)
      end
    end
  end
end
