# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
include FactoryBot::Syntax::Methods

company_logo_path = Rails.root.join('spec/fixtures/company_logos/starbucks-coffee-logo-vector-200x200.png')
logo = Rack::Test::UploadedFile.new(company_logo_path, 'image/jpg')

categories = [
  'beauty salon',
  'car repair',
  'car wash',
  'bowling',
  'golf',
  'school',
  'photography',
  'hostpital',
  'clinic',
  'hotel',
  'motel',
  'car parking',
  'fitness',
  'restaurant',
  'museum',
  'bank',
  'theatre',
  'retailer',
  'amusement park',
  'food manufactor',
  'cloth manufactor',
  'people',
  'service',
  'building'
].map do |name|
  Category.create(name: name)
end

10.times do
  Company.create(
    name: Faker::Company.unique.name,
    ratings: rand(10),
    price_range: rand(10_000..100_000),
    description: Faker::Lorem.sentence,
    owner_name: Faker::Name.first_name,
    established_at: Faker::Date.between(from: 3.years.ago, to: Date.today),
    phone_number: Faker::PhoneNumber.phone_number_with_country_code,
    industry: Faker::Company.industry,
    logo: logo,
    category: categories.sample,
    address: Faker::Address.full_address,
    web_url: Faker::Internet.url
  )
end

avatar_path = Rails.root.join('spec/fixtures/avatar_icons/profile_pic.jpeg')
avatar_icon = Rack::Test::UploadedFile.new(avatar_path, 'image/jpeg')

100.times do
  User.new(
    email: Faker::Internet.unique.email,
    phone_number: Faker::PhoneNumber.unique.phone_number,
    password: '!QAZ2wsx',
    avatar_icon: avatar_icon
  ).save
end
