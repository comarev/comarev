require 'rails_helper'

RSpec.describe Invite, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:inviter) }
    it { is_expected.to belong_to(:company) }
  end

  describe 'has_secure_token' do
    it { is_expected.to have_secure_token(:invitation_token) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:invited_email) }
  end

  describe 'scopes' do
    describe '.not_expired' do
      subject { described_class.not_expired }

      let!(:expired_invite) { create(:invite, updated_at: 31.days.ago) }
      let!(:fresh_invite) { create(:invite) }

      it { is_expected.to include(fresh_invite) }
      it { is_expected.not_to include(expired_invite) }
    end

    describe '.available' do
      subject { described_class.available }

      let!(:unreplied_invite) { create(:invite) }
      let!(:replied_invite) { create(:invite, replied_at: Time.current) }

      it { is_expected.to include(unreplied_invite) }
      it { is_expected.not_to include(replied_invite) }
    end

    describe '.refused' do
      subject { described_class.refused }

      let!(:refused_invite) { create(:invite, accepted: false) }
      let!(:accepted_invite) { create(:invite, accepted: true) }

      it { is_expected.to include(refused_invite) }
      it { is_expected.not_to include(accepted_invite) }
    end

    describe '.recently_refused' do
      subject { described_class.recently_refused }

      let!(:formerly_refused_invite) { create(:invite, accepted: false, replied_at: 1.month.ago) }
      let!(:recently_refused_invite) { create(:invite, accepted: false, replied_at: 1.minute.ago) }

      it { is_expected.to include(recently_refused_invite) }
      it { is_expected.not_to include(formerly_refused_invite) }
    end
  end

  describe '.accept' do
    subject(:accept_invite) { invite.accept }

    context 'when the invited email was not registered' do
      let!(:invite) { create(:invite) }

      it { is_expected.to eq(false) }

      it 'does not invalidate the invite' do
        accept_invite
        expect(described_class.available).to include(invite)
      end

      it 'does not update the invite' do
        accept_invite
        expect(invite.accepted).to be(nil)
      end
    end

    context 'when the invited email was registered' do
      let(:employee) { create(:user) }
      let!(:invite) { create(:invite, invited_email: employee.email) }

      it 'invalidates the invite' do
        accept_invite
        expect(described_class.available).not_to include(invite)
      end

      it 'creates a company_user relation' do
        expect { accept_invite }.to change(CompanyUser, :count).by(1)
      end
    end
  end

  describe '.refuse' do
    subject(:refuse_invite) { invite.refuse }

    let!(:invite) { create(:invite) }

    it 'invalidates the invite' do
      refuse_invite
      expect(described_class.available).not_to include(invite)
    end
  end
end
