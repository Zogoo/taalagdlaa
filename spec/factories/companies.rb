FactoryBot.define do
  factory :company do
    name { Faker::Company.name.downcase }
    label { Faker::Company.name }
    rating { rand(10) }
    description { Faker::Company.industry }
    owner_name { Faker::Name.name }
    established_at { Faker::Date.between(from: 10.years.ago, to: Date.today) }
    address { Faker::Address.full_address }
    phone_number { Faker::PhoneNumber.phone_number_with_country_code }
    industry { Faker::Company.industry }
    web_url { Faker::Internet.url }
    price_range { rand(10_000..100_000) }

    trait(:with_logo) do
      logo do
        fixture_path = Rails.root.join('spec/fixtures/company_logos/starbucks-coffee-logo-vector-200x200.png')
        Rack::Test::UploadedFile.new(fixture_path, 'image/jpg')
      end
    end
  end
end
