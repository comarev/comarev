require 'rails_helper'

RSpec.describe InvoiceMailer, type: :mailer do
  describe 'notify_user_email' do
    subject(:mail) { described_class.notify_user_email(user) }

    let(:user) { create(:user) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Comarev - Lembrete de expiração de fatura.')
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['test@test.com'])
    end
  end
end
