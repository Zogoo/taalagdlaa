FactoryBot.define do
  factory :photo do
    association :review, strategy: :build

    image do
      photo = %w[book.png	game.jpeg	glass.jpg	iphone.jpeg	people.jpeg	review.jpeg]
      fixture_path = Rails.root.join("spec/fixtures/review_photos/#{photo.sample}")
      Rack::Test::UploadedFile.new(fixture_path, 'image/jpg')
    end
  end
end
