require 'rails_helper'

RSpec.describe User, type: :request do
  let(:user) { create(:user, :admin) }
  let(:headers) { { Authorization: sign_in(user) } }

  describe 'GET /index' do
    subject(:fetch_users) do
      get users_path, headers: headers
    end

    let(:users) { create_list(:user, 2) }

    before do
      users
    end

    it 'returns the correct 200 response code' do
      fetch_users

      expect(response).to have_http_status(:ok)
    end

    it 'returns the expected response body' do
      fetch_users

      expect(json).to eq(serialize_all(users))
    end
  end

  describe 'GET /show' do
    subject(:fetch_user) do
      get user_path(target_user), headers: headers
    end

    context 'when the user exists' do
      let(:target_user) { create(:user) }

      it 'returns the correct 200 response code' do
        fetch_user

        expect(response).to have_http_status(:ok)
      end

      it 'returns the expected response body' do
        fetch_user

        expect(json).to eq(serialize(target_user))
      end
    end

    context 'when the user is not found' do
      let(:target_user) { 'inexistent' }

      it 'returns the correct 404 response code' do
        fetch_user

        expect(response).to have_http_status(:not_found)
      end

      it 'returns the expected response body' do
        fetch_user

        expect(json).to eq(message: "Couldn't find User with 'id'=inexistent")
      end
    end
  end

  describe 'POST /create' do
    subject(:create_user) do
      post users_path, params: { user: user_params }, headers: headers
    end

    before { headers }

    context 'with valid data' do
      let(:user_params) { attributes_for(:user, full_name: 'Mary Jane') }

      it 'returns the correct 201 response code' do
        create_user

        expect(response).to have_http_status(:created)
      end

      it 'creates the new record' do
        expect do
          create_user
        end.to change(described_class, :count).by(1)
      end

      it 'returns the expected response body' do
        create_user

        expect(json).to include(full_name: 'Mary Jane')
      end
    end

    context 'with invalid data' do
      let(:user_params) { attributes_for(:user, full_name: nil) }

      it 'returns the correct 422 response code' do
        create_user

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not create the new record' do
        expect { create_user }.not_to change(described_class, :count)
      end

      it 'returns the expected response body' do
        create_user

        expect(json).to include('Nome completo não pode ficar em branco')
      end
    end

    context 'with missing required param key' do
      let(:user_params) do
        {}
      end

      it 'returns the correct 422 response code' do
        create_user

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns the expected response body' do
        create_user

        expect(json)
          .to include(
            message: 'param is missing or the value is empty: user'
          )
      end
    end
  end

  describe 'PATCH /update' do
    subject(:update_user) do
      patch user_path(target_user),
        params: user_params,
        headers: headers
    end

    before { headers }

    context 'when the user exists' do
      let(:target_user) { create(:user) }

      context 'with valid data' do
        let(:user_params) do
          {
            user: {
              email: 'target_user@email.com'
            }
          }
        end

        it 'returns the correct 200 response code' do
          expect do
            update_user
          end.to change(described_class, :count).by(1)

          expect(response).to have_http_status(:ok)
        end

        it 'returns the expected response body' do
          update_user

          expect(json).to include(
            email: 'target_user@email.com'
          )
        end
      end

      context 'with invalid data' do
        let(:user_params) do
          {
            user: {
              email: nil
            }
          }
        end

        it 'returns the correct 422 response code' do
          update_user

          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'returns the expected response body' do
          update_user

          expect(json).to include('E-mail não pode ficar em branco')
        end
      end

      context 'with missing required param key' do
        let(:user_params) do
          {}
        end

        it 'returns the correct 422 response code' do
          update_user

          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'returns the expected response body' do
          update_user

          expect(json)
            .to include(
              message: 'param is missing or the value is empty: user'
            )
        end
      end
    end

    context 'when the user is not found' do
      let(:target_user) { 'inexistent' }
      let(:user_params) { {} }

      it 'returns the correct 404 response code' do
        update_user

        expect(response).to have_http_status(:not_found)
      end

      it 'returns the expected response body' do
        update_user

        expect(json).to eq(message: "Couldn't find User with 'id'=inexistent")
      end
    end
  end

  describe 'DELETE /destroy' do
    subject(:destroy_user) do
      delete user_path(target_user), headers: headers
    end

    context 'when the user exists' do
      let(:target_user) { create(:user, full_name: 'John') }

      it 'returns the correct 200 response code' do
        destroy_user

        expect(response).to have_http_status(:ok)
      end

      it 'returns the expect response body' do
        destroy_user

        expect(json)
          .to include(
            full_name: 'John'
          )
      end
    end

    context 'when the user is not found' do
      let(:target_user) { 'inexistent' }

      it 'returns the correct 404 response code' do
        destroy_user

        expect(response).to have_http_status(:not_found)
      end

      it 'returns the expect response body' do
        destroy_user

        expect(json).to eq(message: "Couldn't find User with 'id'=inexistent")
      end
    end
  end
end
