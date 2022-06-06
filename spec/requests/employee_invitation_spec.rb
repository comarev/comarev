require 'rails_helper'

RSpec.describe 'EmployeeInvitationController', type: :request do
  let(:user) { create(:user, :admin) }
  let(:not_listed_user) { create(:user) }
  let(:company) { create(:company) }
  let(:headers) { { Authorization: sign_in(user) } }

  describe 'POST /companies/:company_id/employee_invitations' do
    context 'when the user is not registered on Comarev' do
      subject(:invitation_controller) do
        post company_employee_invitation_path(company),
          params: { email: 'test_email@test.com' }, headers: headers
      end

      it 'returns status ok' do
        invitation_controller

        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the user is already listed on a Company' do
      subject(:invitation_controller) do
        post company_employee_invitation_path(company), params: { email: user.email },
          headers: headers
      end

      before do
        create(:company_user, user: user, company: company)
      end

      it 'returns status unprocessable entity' do
        invitation_controller

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when the user is not listed on a Company' do
      subject(:invitation_controller) do
        post company_employee_invitation_path(company), params: { email: not_listed_user.email },
          headers: headers
      end

      it 'returns status ok' do
        invitation_controller

        expect(response).to have_http_status(:ok)
      end
    end
  end
end
