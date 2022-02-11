require 'rails_helper'

RSpec.describe 'InvoicesController', type: :request do
  let(:user) { create(:user, :admin) }
  let(:headers) { { Authorization: sign_in(user) } }

  describe 'GET /companies/:company_id/discount_requests' do
    subject(:fetch_discount_requests) do
      get company_discount_requests_path(company), headers: headers
    end

    let(:company) { create(:company) }
    let(:other_company) { create(:company) }

    let!(:discount_requests) { create_list(:discount_request, 2, company: company) }
    let!(:other_discount_requests) { create_list(:discount_request, 2, company: other_company) }

    it 'returns http_status ok' do
      fetch_discount_requests

      expect(response).to have_http_status(:ok)
      expect(json).to eq(serialize_all(discount_requests))
    end

    it 'does not return other company discount requests' do
      fetch_discount_requests

      expect(json).not_to include(serialize(other_discount_requests.first))
    end
  end
end
