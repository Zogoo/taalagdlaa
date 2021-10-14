FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    phone_number { Faker::PhoneNumber.cell_phone }
    password { '!QAZ2wsx' }
    last_sign_in_at { Time.now }
    confirmed_at { Time.now }

    trait(:with_avatar) do
      avatar_icon do
        avatars = %w[avatar_empty_man.png avatar_empty_woman.png profile_pic.jpeg]
        path = Rails.root.join("spec/fixtures/avatar_icons/#{avatars.sample}")
        Rack::Test::UploadedFile.new(path, 'image/jpeg')
      end
    end
  end
end
