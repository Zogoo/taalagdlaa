FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    phone_number { Faker::PhoneNumber.cell_phone }
    password { 'Password!123' }
    last_sign_in_at { Time.now }
    confirmed_at { Time.now }
  end
end
