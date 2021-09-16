require 'rails_helper'

RSpec.describe CompanyUser, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:company) }
  end

  it 'defines enum for role' do
    is_expected.to define_enum_for(:role)
      .with_values({ regular: 0, manager: 1 })
      .backed_by_column_of_type(:integer)
  end
end
