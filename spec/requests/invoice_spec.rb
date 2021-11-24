require 'rails_helper'

RSpec.describe Invoice, type: :request do
  let(:user) { create(:user, :admin) }
  let(:headers) { { "Authorization": sign_in(user) } }

  describe 'GET #index' do
    it 'returns http_status ok' do
      get invoices_path, headers: headers

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST #create' do
    subject(:create_invoice) do
      post invoices_path, params: { invoice: invoice_params }, headers: headers
    end

    let(:invoice_owner) { create(:user) }

    context 'when successfuly' do
      let(:invoice_params) { attributes_for(:invoice, amount: 50.45, user_id: invoice_owner.id) }

      it 'returns the correct 201 response code' do
        create_invoice

        expect(response).to have_http_status(:created)
      end

      it 'creates the new record' do
        expect { create_invoice }.to change(Invoice, :count).by(1)
      end

      it 'returns the expected response body' do
        create_invoice

        expect(json).to include(amount: 50.45)
      end
    end

    context 'when failed' do
      let(:invoice_params) { attributes_for(:invoice, amount: nil, user_id: invoice_owner.id) }

      it 'returns the correct 422 response code' do
        create_invoice

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not create the new record' do
        expect { create_invoice }.not_to change(Invoice, :count)
      end

      it 'returns the expected response body' do
        create_invoice

        expect(json).to include('Valor não pode ficar em branco')
      end
    end
  end

  describe 'PATCH #update' do
    subject(:update_invoice) do
      patch invoice_path(invoice), params: { invoice: invoice_params }, headers: headers
    end

    let!(:invoice) { create(:invoice, amount: 50.45, paid: false) }

    context 'when successfuly' do
      let(:invoice_params) { { paid: true } }

      it 'updates the invoice' do
        expect { update_invoice }.to change { invoice.reload.paid }.from(false).to(true)
      end

      it 'returns the expected', :aggregate_failures do
        update_invoice

        expect(response).to have_http_status(:ok)
        expect(json).to include(paid: true)
      end
    end

    context 'when failed' do
      let(:invoice_params) { { paid: nil, amount: nil } }

      it 'does not update the invoice' do
        expect { update_invoice }.not_to(change { invoice.reload.paid })
      end

      it 'returns the correct 422 response code', :aggregate_failures do
        update_invoice

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json).to include('Valor não pode ficar em branco')
        expect(json).to include('Valor não é um número')
      end
    end
  end
end
