require 'rails_helper'

RSpec.describe 'EmployeeInvitationController', type: :request do
  let(:user) { create(:user, :admin) }
  let(:not_listed_user) { create(:user) }
  let(:company) { create(:company) }
  let(:headers) { { Authorization: sign_in(user) } }

  describe 'POST /companies/:company_id/employee_invitations' do
    subject(:create_invitation) do
      post company_employee_invitation_path(company),
        params: { email: current_email }, headers: headers
    end

    context 'when the user is not registered on comarev' do
      let(:current_email) { 'test_test@email.com' }

      before do
        allow(InviteEmployeeService).to receive(:call)
          .and_return({ message: 'Email sent to new user', status: :ok })
      end

      it "returns status ok with 'email sent to new user' message" do
        create_invitation

        expect(response).to have_http_status(:ok)
        expect(response.body).to eq({ message: 'Email sent to new user' }.to_json)
      end
    end

    context 'when the user is already listed on a company' do
      let(:current_email) { user.email }

      before do
        create(:company_user, user: user, company: company)
        allow(InviteEmployeeService).to receive(:call)
          .and_return({ message: "User is already listed
            as #{company.name}'s employee",
                        status: :unprocessable_entity })
      end

      it "returns status unprocessable entity with 'already listed' message" do
        create_invitation

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to eq({ message: "User is already listed
            as #{company.name}'s employee" }.to_json)
      end
    end

    context 'when the user is not listed on a company' do
      let(:current_email) { not_listed_user.email }

      before do
        allow(InviteEmployeeService).to receive(:call)
          .and_return({ message: "User successfully listed
            as #{company.name}'s employee" })
      end

      it "returns status ok with user 'successfully listed' message" do
        create_invitation

        expect(response).to have_http_status(:ok)
        expect(response.body).to eq({ message: "User successfully listed
            as #{company.name}'s employee" }.to_json)
      end
    end

    context 'when the endpoint is called' do
      let(:current_email) { user.email }

      before do
        allow(InviteEmployeeService).to receive(:call).with(user, user.email,
          company).and_return({ message: 'mocked service message', status: :ok })
      end

      it 'calls the service object' do
        create_invitation

        expect(InviteEmployeeService).to have_received(:call)
          .with(user, current_email, company).once
        expect(response.body).to eq({ message: 'mocked service message' }.to_json)
      end
    end
  end

  describe 'PATCH /companies/:company_id/employee_invitations' do
    subject(:reply_invitation) do
      patch company_employee_invitation_path(company),
        params: { accepted: accepted_params, token: invite.invitation_token },
        headers: headers, as: :json
    end

    context 'when the accepted parameter is true' do
      let(:accepted_params) { true }

      context 'when the invite does not exist on database' do
        let(:invite) { build(:invite) }

        it "returns status unprocessable entity with 'invite could not replied' message" do
          reply_invitation

          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.body).to eq({ message: 'invite could not replied' }.to_json)
        end
      end

      context 'when employee was registered' do
        let(:employee) { create(:user) }
        let(:invite) { create(:invite, invited_email: employee.email) }

        it "returns status ok with 'Invite accepted' message" do
          reply_invitation

          expect(response).to have_http_status(:ok)
          expect(response.body).to eq({ message: 'invite accepted' }.to_json)
        end
      end

      context 'when employee was not registered' do
        let(:invite) { create(:invite) }

        it "returns status unprocessable entity with 'invite could not replied' message" do
          reply_invitation

          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.body).to eq({ message: 'invite could not replied' }.to_json)
        end
      end

      context 'when the invite is expired' do
        let(:invite) { create(:invite, updated_at: 31.days.ago) }

        it "returns status unprocessable entity with 'invite could not replied' message" do
          reply_invitation

          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.body).to eq({ message: 'invite could not replied' }.to_json)
        end
      end

      context 'when the invite was already replied' do
        let(:invite) { create(:invite, replied_at: Time.current) }

        it "returns status unprocessable entity with 'invite could not replied' message" do
          reply_invitation

          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.body).to eq({ message: 'invite could not replied' }.to_json)
        end
      end
    end

    context 'when the accepted parameter is false' do
      let(:accepted_params) { false }
      let(:employee) { create(:user) }
      let(:invite) { create(:invite, invited_email: employee.email) }

      it "returns status ok with 'invite refused' message" do
        reply_invitation

        expect(response).to have_http_status(:ok)
        expect(response.body).to eq({ message: 'invite refused' }.to_json)
      end
    end
  end
end
