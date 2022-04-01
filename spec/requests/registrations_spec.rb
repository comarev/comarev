require 'rails_helper'

RSpec.describe 'Registrations', type: :request do
  describe 'POST /signup' do
    subject(:request) { post signup_path, params: params, as: :json }

    context 'without logged in user', :aggregate_failures do
      context 'with valid params' do
        let(:params) { { user: attributes_for(:user, full_name: 'Mary Jane') } }

        let(:new_user) { User.last }

        let(:expected_body) do
          {
            active: false,
            address: new_user.address,
            admin: false,
            cellphone: new_user.cellphone,
            companies: [],
            cpf: new_user.cpf,
            created_at: new_user.created_at.iso8601(3),
            email: new_user.email,
            full_name: new_user.full_name,
            id: new_user.id,
            picture_url: nil,
            self_registered: true,
            updated_at: new_user.updated_at.iso8601(3)
          }
        end

        it 'shows success message' do
          request

          expect(json).to eq expected_body
          expect(response).to be_successful
        end

        it 'creates a new record in the database' do
          expect { request }.to change(User, :count).by(1)
        end
      end

      context 'with invalid params' do
        let(:params) { { user: attributes_for(:user, full_name: nil) } }

        it 'shows invalid params message' do
          request

          expect(json).to eq(errors: { full_name: ['não pode ficar em branco'] })
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context 'without params' do
        let(:params) { {} }
        let(:expected_body) do
          {
            errors: {
              email: ['não pode ficar em branco'],
              full_name: ['não pode ficar em branco'],
              cellphone: [
                'não pode ficar em branco',
                'não possui o tamanho esperado (15 caracteres)'
              ],
              address: ['não pode ficar em branco'],
              cpf: ['não pode ficar em branco', 'não possui o tamanho esperado (11 caracteres)']
            }
          }
        end

        it 'shows invalid params message' do
          request

          expect(json).to eq expected_body
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end
end
