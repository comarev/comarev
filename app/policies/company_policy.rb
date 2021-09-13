class CompanyPolicy < ApplicationPolicy
  DEFAULT_ATTRS = %i[name cnpj address phone active code discount].push(user_ids: [])

  def permitted_attributes
    DEFAULT_ATTRS
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

  def index?
    user.admin?
  end

  def show?
    user.admin?
  end
end
