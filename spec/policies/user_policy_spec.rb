require 'rails_helper'

describe UserPolicy do
  subject { described_class.new(user, new_user) }

  let(:new_user) { build_stubbed(:user) }

  context 'when a regular user' do
    let(:user) { build_stubbed(:user) }

    it { is_expected.not_to authorize(:create) }
    it { is_expected.not_to authorize(:update) }
    it { is_expected.not_to authorize(:destroy) }
    it { is_expected.not_to authorize(:index) }
  end

  context 'when regular users trying to manage themselves' do
    let(:user) { build_stubbed(:user) }
    let(:new_user) { user }

    it { is_expected.to authorize(:update) }
    it { is_expected.not_to authorize(:create) }
    it { is_expected.not_to authorize(:destroy) }
    it { is_expected.not_to authorize(:index) }
  end

  context 'when an admin user' do
    let(:user) { build_stubbed(:user, :admin) }

    it { is_expected.to authorize(:create) }
    it { is_expected.to authorize(:update) }
    it { is_expected.to authorize(:destroy) }
    it { is_expected.to authorize(:index) }
  end

  describe '#permitted_attributes' do
    subject { described_class.new(user, record).permitted_attributes }

    context 'when admin user' do
      let(:user) { create(:user, :admin) }
      let(:record) { create(:user) }

      it do
        is_expected.to match_array %i[
          full_name email password address cellphone active admin
        ]
      end
    end

    context 'when regular user' do
      let(:user) { create(:user) }
      let(:record) { user }

      it do
        is_expected.to match_array %i[
          full_name email password address cellphone
        ]
      end
    end
  end
end
