require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'assocation' do
    context 'when create review with photo' do
      let(:user) { create(:user) }
      let(:company) { create(:company) }
      let(:user_review) { create(:review, user: user, company: company) }
      let!(:review_photo) { create(:photo, review: user_review) }

      it 'will have relation with photo' do
        expect(user_review.photos.count).to eq(1)
      end
    end
  end
end
