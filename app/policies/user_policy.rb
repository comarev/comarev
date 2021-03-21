class UserPolicy < ApplicationPolicy
  def create?
    user.admin?
  end
end
