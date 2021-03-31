require 'rails_helper'

describe UserPolicy do
  subject { UserPolicy.new(user, new_user) }

  let(:new_user) { create(:user) }

  context "for a regular user" do
    let(:user) { create(:user) }

    it { should_not authorize(:create) }
    it { should_not authorize(:destroy) }
  end

  context "for a admin user" do
    let(:user) { create(:user, :admin) }

    it { should authorize(:create) }
    it { should authorize(:destroy) }
  end
end
