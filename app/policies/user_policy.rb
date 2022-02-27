class UserPolicy < ApplicationPolicy
  DEFAULT_ATTRS = %i[full_name email password address cellphone].freeze
  ADMIN_ATTRS = %i[admin active].freeze

  def permitted_attributes
    if user.admin?
      DEFAULT_ATTRS + ADMIN_ATTRS
    else
      DEFAULT_ATTRS
    end
  end

  def create?
    user.admin?
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end
end
