class CompanyPolicy < ApplicationPolicy
  DEFAULT_ATTRS = %i[name cnpj address phone active avatar].push(manager_ids: [], regular_ids: [])
  ADMIN_ATTRS = %i[discount].freeze

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.joins(:users).where(users: { id: user.id })
      end
    end
  end

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
    user.admin? || manager?
  end

  def destroy?
    user.admin?
  end

  def index?
    true
  end

  def show?
    user.admin? || belongs_to_company?
  end

  def discount_requests?
    show?
  end

  private

  def manager?
    user.company_user_for(record.id)&.manager?
  end

  def belongs_to_company?
    record.company_users.pluck(:user_id).include?(user.id)
  end
end
