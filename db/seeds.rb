# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
fixture_path = Rails.root.join('spec/fixtures/company_logos/starbucks-coffee-logo-vector-200x200.png')
logo = Rack::Test::UploadedFile.new(fixture_path, 'image/jpg')

10.times do
  Company.create(
    name: Faker::Name.first_name,
    rating: rand(10),
    description: Faker::Lorem.sentence,
    owner_name: Faker::Name.first_name,
    established_at: Faker::Date.between(from: 3.years.ago, to: Date.today),
    phone_number: Faker::PhoneNumber.phone_number_with_country_code,
    industry: Faker::Company.industry,
    logo: logo
  )
end
