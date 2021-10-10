FactoryBot.define do
  factory :photo do
    association :review, strategy: :build

    image do
      fixture_path = Rails.root.join('spec/fixtures/review_photos/review.jpg')
      Rack::Test::UploadedFile.new(fixture_path, 'image/jpg')
    end
  end
end
