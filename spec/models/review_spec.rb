require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'assocation' do
    context 'when create review with photo' do
      let(:review_photo) { create(:photo) }
      let(:user_review) { create(:review, photo: review_photo) }

      it 'will have relation with photo' do
        expect(user_review.photos.count).to eq(1)
      end
    end
  end
end
