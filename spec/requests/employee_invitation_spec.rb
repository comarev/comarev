require 'rails_helper'

RSpec.describe 'EmployeeInvitationController', type: :request do
  let(:user) { create(:user, :admin) }
  let(:company) { create(:company) }
  let(:headers) { { Authorization: sign_in(user) } }
  describe 'POST /companies/:company_id/employee_invitations' do
    subject(:invitation_controller) do
      post company_employee_invitation_path(company), params: {email: "test_email@test.com"}, headers: headers
    end 
      it {is_expected.to have_http_status(:ok)}
  end
end
