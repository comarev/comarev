require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:amount) }
    it { is_expected.to validate_numericality_of(:amount).is_greater_than(0) }
  end

  describe '#status' do
    it do
      is_expected.to define_enum_for(:status).with_values({ in_progress: 0, finished: 1 })
        .backed_by_column_of_type(:integer)
    end
  end

  describe 'scopes' do
    describe '.in_progress' do
      subject { described_class.in_progress }

      let!(:in_progress_invoice) { create(:invoice, status: :in_progress) }
      let!(:finished_invoice) { create(:invoice, status: :finished) }

      it { is_expected.to include(in_progress_invoice) }
      it { is_expected.not_to include(finished_invoice) }
    end

    describe '.finished' do
      subject { described_class.finished }

      let!(:in_progress_invoice) { create(:invoice, status: :in_progress) }
      let!(:finished_invoice) { create(:invoice, status: :finished) }

      it { is_expected.to include(finished_invoice) }
      it { is_expected.not_to include(in_progress_invoice) }
    end
  end
end
