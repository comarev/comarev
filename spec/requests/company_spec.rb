require 'rails_helper'

RSpec.describe Company, type: :request do
  let(:user) { create(:user, :admin) }
  let(:headers) { { "Authorization": sign_in(user) } }

  describe 'GET /index' do
    subject(:fetch_companies) do
      get companies_path, headers: headers
    end

    let!(:companies) { create_list(:company, 2) }

    it 'returns the correct 200 response code' do
      fetch_companies

      expect(response).to have_http_status(:ok)
    end

    it 'returns the expected response body' do
      fetch_companies

      expect(json).to eq(serialize_all(companies.sort_by(&:name)))
    end
  end

  describe 'GET /show' do
    subject(:fetch_company) do
      get company_path(target_company), headers: headers
    end

    context 'when the company exists' do
      let(:target_company) { create(:company) }

      it 'returns the correct 200 response code' do
        fetch_company

        expect(response).to have_http_status(:ok)
      end

      it 'returns the expected response body' do
        fetch_company

        expect(json).to eq(serialize(target_company))
      end
    end

    context 'when company is not found' do
      let(:target_company) { 'inexistent' }

      it 'returns the correct 404 response code' do
        fetch_company

        expect(response).to have_http_status(:not_found)
      end

      it 'returns the expected response body' do
        fetch_company

        expect(json).to eq(message: "Couldn't find Company with 'id'=inexistent")
      end
    end
  end

  describe 'POST /create' do
    before { headers }
    subject(:create_company) do
      post companies_path, params: { company: company_params }, headers: headers
    end

    context 'with valid data' do
      let(:company_params) { attributes_for(:company, name: 'Tesla') }

      it 'returns the correct 201 response code' do
        create_company

        expect(response).to have_http_status(:created)
      end

      it 'creates the new record' do
        expect do
          create_company
        end.to change(Company, :count).by(1)
      end

      it 'returns the expected response body' do
        create_company

        expect(json).to include(name: 'Tesla')
      end
    end

    context 'with invalid data' do
      let(:company_params) { attributes_for(:user, name: nil) }

      it 'returns the correct 422 response code' do
        create_company

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not create the new record' do
        expect { create_company }.not_to change(Company, :count)
      end

      it 'returns the expected response body' do
        create_company

        expect(json).to include('Nome não pode ficar em branco')
      end
    end

    context 'with missing required param key' do
      let(:company_params) do
        {}
      end

      it 'returns the correct 422 response code' do
        create_company

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns the expected response body' do
        create_company

        expect(json)
          .to include(
            message: 'param is missing or the value is empty: company'
          )
      end
    end
  end

  describe 'PATCH /update' do
    before { headers }
    subject(:update_company) do
      patch company_path(target_company),
        params: company_params,
        headers: headers
    end

    context 'when the company exists' do
      let(:target_company) { create(:company) }

      context 'with valid data' do
        let(:company_params) do
          {
            company: {
              name: 'Google'
            }
          }
        end

        it 'returns the correct 200 response code' do
          expect do
            update_company
          end.to change(Company, :count).by(1)

          expect(response).to have_http_status(:ok)
        end

        it 'returns the expected response body' do
          update_company

          expect(json).to include(
            name: 'Google'
          )
        end
      end

      context 'with invalid data' do
        let(:company_params) do
          {
            company: {
              name: nil
            }
          }
        end

        it 'returns the correct 422 response code' do
          update_company

          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'returns the expected response body' do
          update_company

          expect(json)
            .to include('Nome não pode ficar em branco')
        end
      end

      context 'with missing required param key' do
        let(:company_params) do
          {}
        end

        it 'returns the correct 422 response code' do
          update_company

          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'returns the expected response body' do
          update_company

          expect(json)
            .to include(
              message: 'param is missing or the value is empty: company'
            )
        end
      end
    end

    context 'when the company is not found' do
      let(:target_company) { 'inexistent' }
      let(:company_params) { {} }

      it 'returns the correct 404 response code' do
        update_company

        expect(response).to have_http_status(:not_found)
      end

      it 'returns the expected response body' do
        update_company

        expect(json).to eq(message: "Couldn't find Company with 'id'=inexistent")
      end
    end
  end

  describe 'DELETE /destroy' do
    subject(:destroy_company) do
      delete company_path(target_company), headers: headers
    end

    context 'when the user exists' do
      let(:target_company) { create(:company, name: 'Microsoft') }

      it 'returns the correct 200 response code' do
        destroy_company

        expect(response).to have_http_status(:ok)
      end

      it 'returns the expect response body' do
        destroy_company

        expect(json)
          .to include(
            name: 'Microsoft'
          )
      end
    end

    context 'when the user is not found' do
      let(:target_company) { 'inexistent' }

      it 'returns the correct 404 response code' do
        destroy_company

        expect(response).to have_http_status(:not_found)
      end

      it 'returns the expect response body' do
        destroy_company

        expect(json).to eq(message: "Couldn't find Company with 'id'=inexistent")
      end
    end
  end
end
