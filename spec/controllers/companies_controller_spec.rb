require 'spec_helper'

RSpec.describe CompaniesController, type: :controller do
  render_views

  describe '#index' do
    let!(:api_user) { create(:user) }
    let(:index_param) { {} }

    before do
      api_user.save
      10.times do
        create(:company, :with_logo)
      end
    end

    subject do
      get :index, params: index_param, format: :json
    end

    context 'when authenticated user accesed' do
      before do
        request.headers['Authorization'] = api_user.generate_jwt
      end

      it 'will respond success status and body has parsable JSON' do
        is_expected.to have_http_status(:success)
        expect { JSON.parse(response.body) }.not_to raise_error
        expect(JSON.parse(response.body)['companies'].size).to eq(10)
      end
    end

    context 'when unauthorized user accessed' do
      before do
        request.headers['Authorization'] = 'wrong_api_key'
      end

      it 'will respond success status' do
        is_expected.to have_http_status(:success)
      end
    end
  end
end
