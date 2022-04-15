require 'rails_helper'

RSpec.describe Invoice, type: :request do
  let(:user) { create(:user, :admin) }
  let(:headers) { { Authorization: sign_in(user) } }

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

    context 'when successfully' do
      let(:invoice_params) do
        attributes_for(:invoice, amount_cents: 3_500, user_id: invoice_owner.id)
      end

      it 'returns the correct 201 response code' do
        create_invoice

        expect(response).to have_http_status(:created)
      end

      it 'creates the new record' do
        expect { create_invoice }.to change(described_class, :count).by(1)
      end

      it 'returns the expected response body' do
        create_invoice

        expect(json).to include(amount_cents: 3_500)
      end
    end

    context 'when failed' do
      let(:invoice_params) do
        attributes_for(:invoice, amount_cents: nil, user_id: invoice_owner.id)
      end

      it 'returns the correct 422 response code' do
        create_invoice

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not create the new record' do
        expect { create_invoice }.not_to change(described_class, :count)
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

    let!(:invoice) { create(:invoice, amount_cents: 3_500, paid: false) }

    context 'when successfully' do
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
      let(:invoice_params) { { paid: nil, amount_cents: nil } }

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

  describe 'POST #check' do
    subject(:check_invoice) do
      post check_invoices_path, params: { code: code }, headers: headers
    end

    let(:user) { create(:user) }
    let(:company) { create(:company) }
    let(:code) { company.code }

    before { create(:company_user, user: user, company: company) }

    context 'when successfully' do
      it 'creates a DiscountRequest' do
        expect { check_invoice }.to change(DiscountRequest, :count).by(1)
      end

      it 'returns the expected', :aggregate_failures do
        check_invoice

        expect(response).to have_http_status(:ok)
        expect(json).to eq(serialize(company))
      end
    end

    context 'when valid code but invoices not paid' do
      before { create(:invoice, paid: false, user: user) }

      it 'creates a DiscountRequest anyway' do
        expect { check_invoice }.to change(DiscountRequest, :count).by(1)
      end

      it 'returns the correct', :aggregate_failures do
        check_invoice

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to be_empty
      end
    end

    context 'when failed' do
      let(:code) { 'invalid_code' }

      it 'does not create a DiscountRequest' do
        expect { check_invoice }.not_to change(DiscountRequest, :count)
      end

      it 'returns the correct 422 response code', :aggregate_failures do
        check_invoice

        expect(response).to have_http_status(:not_found)
        expect(json).to eq({ message: "Couldn't find Company" })
      end
    end
  end
end
