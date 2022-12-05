require_relative '../rails_helper'

RSpec.describe Search, type: :model do
  let(:search) { create(:search) }
  describe 'Attributes' do
    it { should validate_presence_of(:search_text) }
    it { should validate_presence_of(:search_count) }
    it 'search text must be string' do
      expect(search.search_text).to be_kind_of(String)
    end
    it 'search_count must be an integer' do
      expect(search.search_count).to be_kind_of(Integer)
    end
  end
end
