class UserPolicy < ApplicationPolicy
  DEFAULT_ATTRS = %i[full_name email password address cellphone]
  ADMIN_ATTRS = %i[admin active]

  def permitted_attributes
    if user.admin?
      DEFAULT_ATTRS.concat(ADMIN_ATTRS)
    else
      DEFAULT_ATTRS
    end
  end

  def create?
    user.admin?
  end

  def destroy?
    user.admin?
  end
end
