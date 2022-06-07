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

      it "returns status ok with 'email sent to new user' message" do
        invitation_controller

        expect(response).to have_http_status(:ok)
        expect(json).to eq({message: "Email sent to new user"})
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

      it "returns status unprocessable entity with 'already listed' message" do
        invitation_controller

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json).to eq({message: "User is already listed as #{company.name}'s employee"})
      end
    end

    context 'when the user is not listed on a Company' do
      subject(:invitation_controller) do
        post company_employee_invitation_path(company), params: { email: not_listed_user.email },
          headers: headers
      end

      it "returns status ok with user 'successfully listed' message" do
        invitation_controller

        expect(response).to have_http_status(:ok)
        expect(json).to eq({message:"User successfully listed as #{company.name}'s employee"})
      end
    end
  end
end



  # context 'when the endpoint is called' do
  #   subject(:invitation_controller) do
  #     post company_employee_invitation_path(company), params: { email: user.email },
  #       headers: headers
  #   end
  #   it 'calls the service object' do
  #     invite_service_mock = instance_double('CheckEmployeeAssociation')
  #     expect(invite_service_mock).to receive(:call).once
  #     invitation_controller
  #   end
  # end
