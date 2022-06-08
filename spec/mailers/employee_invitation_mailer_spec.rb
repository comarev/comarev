require 'rails_helper'

RSpec.describe EmployeeInvitationMailer, type: :mailer do
  describe '#invite_employee' do
    subject(:email) { described_class.with(email: to_email).invite_employee }

    let(:to_email) { 'test@email.com' }

    it 'sends the new user email' do
      expect(email.subject).to eq('Comarev - Invitation to join in')
      expect(email.to).to eq(['test@email.com'])
      expect(email.from).to eq(['test@test.com'])
      expect(email.body.encoded).to match('You have been invited to join a company')
      expect(email.body.encoded).to match('In order to accept, you must be logged in first.')
      expect { email.deliver_now }.to change { described_class.deliveries.count }.by(1)
    end
  end
end
