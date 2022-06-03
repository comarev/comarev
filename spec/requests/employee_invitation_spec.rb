require 'rails_helper'

RSpec.describe 'EmployeeInvitationController', type: :request do
  let(:user) { create(:user, :admin) }
  let(:not_listed_user) { create(:user) }
  let(:company) { create(:company) }
  let!(:company_user) { create(:company_user, user: user, company: company) }
  let(:headers) { { Authorization: sign_in(user) } }
  
  describe 'POST /companies/:company_id/employee_invitations' do
    context 'When user is no registered on Comarev' do
      subject(:invitation_controller) do
        post company_employee_invitation_path(company), params: {email: "test_email@test.com"}, headers: headers
      end

        it { is_expected.to eq(200) }
      end

    context 'When user already is listed on a Company'do
      subject(:invitation_controller) do
        post company_employee_invitation_path(company), params: {email: user.email}, headers: headers
      end

        it { is_expected.to eq(422) }
    end
    context 'When user is not listed on a Company' do
      subject(:invitation_controller) do
        post company_employee_invitation_path(company), params: {email: not_listed_user.email}, headers: headers
      end

        it { is_expected.to eq(200) }
    end
  end
end
