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

  context 'when an admin user' do
    let(:user) { build_stubbed(:user, :admin) }

    it { is_expected.to authorize(:create) }
    it { is_expected.to authorize(:update) }
    it { is_expected.to authorize(:destroy) }
    it { is_expected.to authorize(:index) }
  end
end
