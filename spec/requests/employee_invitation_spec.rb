require 'rails_helper'

RSpec.describe 'EmployeeInvitationController', type: :request do
  let(:user) { create(:user, :admin) }
  let(:not_listed_user) { create(:user) }
  let(:company) { create(:company) }
  let(:headers) { { Authorization: sign_in(user) } }

  describe 'POST /companies/:company_id/employee_invitations' do
    subject(:invitation_controller) do
      post company_employee_invitation_path(company),
        params: { email: current_email }, headers: headers
    end

    context 'when the user is not registered on comarev' do
      let(:current_email) { 'test_test@email.com' }

      it "returns status ok with 'email sent to new user' message" do
        invitation_controller

        expect(response).to have_http_status(:ok)
        expect(json).to eq({ message: 'Email sent to new user' })
      end
    end

    context 'when the user is already listed on a company' do
      let(:current_email) { user.email }

      before do
        create(:company_user, user: user, company: company)
      end

      it "returns status unprocessable entity with 'already listed' message" do
        invitation_controller

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json).to eq({ message: "User is already listed as #{company.name}'s employee" }
      end
    end

    context 'when the user is not listed on a company' do
      let(:current_email) { not_listed_user.email }

      it "returns status ok with user 'successfully listed' message" do
        invitation_controller

        expect(response).to have_http_status(:ok)
        expect(response.body).to eq({ message: "User successfully listed as #{company.name}'s employee" }.to_json)
      end
    end

    context 'when the endpoint is called' do
      let(:current_email) { user.email }

      before do
        allow(CheckEmployeeAssociation).to receive(:call).with(user, user.email,
          company).and_return({ message: 'mocked service message', status: :ok })
      end

      it 'calls the service object' do
        invitation_controller

        expect(CheckEmployeeAssociation).to have_received(:call)
          .with(user, current_email,company).once
        expect(response.body).to eq({ message: 'mocked service message' }.to_json)
      end
    end
  end
end
