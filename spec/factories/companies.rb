FactoryBot.define do
  factory :company do
    name { Faker::Company.name.downcase }
    label { Faker::Company.name }
    ratings { rand(10) }
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
        logo_name = %w[adidas-logo-vector-01.png bmw-logo-200x200.png gucci-logo-vector.jpeg nike-logo-vector-01.png starbucks-coffee-logo-vector-200x200.png
                       american-express-logo-200x200.png facebook-logo-vector-ai-200x200.png mercedes-benz-logo-vector-01.png pepsi-logo-vector-01-200x200.png
                       apple-logo-vector-01-200x200.png google-logo-vector-200x200.png new-microsoft-logo-2012-logo-vector-01-200x200.png polo-ralph-lauren-logo-vector-200x200.png]
        fixture_path = Rails.root.join("spec/fixtures/company_logos/#{logo_name.sample}")
        Rack::Test::UploadedFile.new(fixture_path, 'image/jpg')
      end
    end
  end
end
