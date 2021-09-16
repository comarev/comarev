class CompanyPolicy < ApplicationPolicy
  DEFAULT_ATTRS = %i[name cnpj address phone active code discount].push(user_ids: [])

  def permitted_attributes
    DEFAULT_ATTRS
  end

  def create?
    user.admin?
  end

  def update?
    user.admin? || (belongs_to_company? && manager?)
  end

  def destroy?
    user.admin?
  end

  def index?
    user.admin?
  end

  def show?
    user.admin? || belongs_to_company?
  end

  private

  def manager?
    user.company_user_for(record.id)&.manager?
  end

  def belongs_to_company?
    record.users.include?(user)
  end
end
