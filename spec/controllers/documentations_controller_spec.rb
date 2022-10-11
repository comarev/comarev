require 'rails_helper'

RSpec.describe 'Documentations', type: :request do
  describe 'GET /docs' do
    subject(:docs) { get docs_path }

    before { docs }

    it { expect(response).to have_http_status(:ok) }
    it { expect(response.content_type).to eq('text/html; charset=utf-8') }
    it { expect(response.body).to include('Comarev - API docs') }
  end

  describe 'GET /swagger' do
    subject(:swagger_config) { get swagger_path }

    let(:expected_response) do
      JSON.parse File.read(Rails.root.join('config/swagger.json')), symbolize_names: true
    end

    before { swagger_config }

    it { expect(response).to have_http_status(:ok) }
    it { expect(response.content_type).to eq('application/json; charset=utf-8') }
    it { expect(json).to eq(expected_response) }
  end
end
