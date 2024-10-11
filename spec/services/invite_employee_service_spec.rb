require 'rails_helper'

RSpec.describe InviteEmployeeService, type: :service do
  let(:inviter) { create(:user) }
  let(:company) { create(:company) }
  let(:employee) { create(:user) }

  describe '.call' do
    subject(:invite_employee) { described_class.call(*args) }

    context 'when the user not registered on comarev yet' do
      let(:args) { [inviter, 'not_registered_email', company] }

      it { is_expected.to eq({ message: 'Invitation sent', status: :ok }) }
    end

    context "when the user is already listed as this company's employee" do
      let(:args) { [inviter, employee.email, company] }

      before { create(:company_user, user: employee, company: company) }

      it do
        is_expected.to eq({ message: "User is already listed as #{company.name}'s employee",
                            status: :unprocessable_entity })
      end
    end

    context 'when the user was already invited to the company' do
      let(:args) { [inviter, employee.email, company] }

      before { Invite.create!(inviter: inviter, invited_email: employee.email, company: company) }

      it {
        is_expected.to eq({ message: "User was already invited to #{company.name}",
       status: :unprocessable_entity })
      }
    end

    context 'when the user recently refused this invite' do
      let(:args) { [inviter, employee.email, company] }

      before do
        Invite.create!(inviter: inviter, invited_email: employee.email, company: company).refuse
      end

      it {
        is_expected.to eq({ message: 'Invite recently refused', status: :unprocessable_entity })
      }
    end
  end
end
