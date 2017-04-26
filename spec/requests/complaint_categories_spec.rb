require 'rails_helper'

RSpec.describe 'ComplaintCategories', type: :request do
  describe 'GET /complaint_categories' do
    it 'works! (now write some real specs)' do
      get complaint_categories_path
      expect(response).to have_http_status(200)
    end
  end
end
