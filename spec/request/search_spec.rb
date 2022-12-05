require 'rails_helper'

RSpec.describe 'Searches', type: :request do
  let(:search) { create(:search) }

  describe 'GET /' do
    before(:example) { get('/') }
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /searches' do
    before(:example) { get('/searches') }
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'Post /destroy' do
    before(:example) do
      post('/searches', params: {
             'search_text' => 'How old is your car'
           })
    end
    it 'returns http success' do
      expect(response).to have_http_status(:ok)
    end
  end
end
