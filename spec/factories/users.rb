FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    phone_number { Faker::PhoneNumber.cell_phone }
    password { 'Password!123' }
    last_sign_in_at { Time.now }
    confirmed_at { Time.now }

    trait(:with_avatar) do
      avatar_icon do
        fixture_path = Rails.root.join('spec/fixtures/avatar_icons/profile_pic.jpeg')
        Rack::Test::UploadedFile.new(fixture_path, 'image/jpeg')
      end
    end
  end
end
