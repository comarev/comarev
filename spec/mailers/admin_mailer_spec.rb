require 'rails_helper'

RSpec.describe AdminMailer, type: :mailer do
  describe '#user_self_registration_notification' do
    subject(:email) do
      described_class.user_self_registration_notification(user: user, admin_emails: [admin.email])
    end

    let(:user) { build_stubbed(:user, self_registered: true) }
    let(:admin) { build_stubbed(:user, :admin) }

    it 'delivers the email' do
      expect { email.deliver_now }.to change(described_class.deliveries, :count).by(1)
    end

    it 'shows correct messages', :aggregate_failures do
      expect(email.to).to eq [admin.email]
      expect(email.from).to eq ['from@example.com']
      expect(email.subject).to eq "Novo usuário cadastrado - #{user.full_name}"

      expect(email.body).to include('Um novo usuário se cadastrou no sistema.')
      expect(email.body).to include("O e-mail do novo usuário é <strong>#{user.email}</strong>")

      expect(email.body).to include(
        'Para que o usuário seja capaz de acessar o sistema, '\
        'ele deverá ser ativado manualmente.'
      )
    end
  end
end
