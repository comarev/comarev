require 'rails_helper'

describe UserPolicy do
  subject { UserPolicy }

  permissions :create?, :destroy? do
    it "denies access if user is not an admin" do
      expect(subject).not_to permit(User.new(admin: false), User.new)
    end
  end
end
