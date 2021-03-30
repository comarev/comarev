class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    user.admin?
  end

  def create?
    admin_or_current_user?
  end

  def show?
    admin_or_current_user?
  end

  def update?
    admin_or_current_user?
  end

  def destroy?
    admin_or_current_user?
  end

  private

  def admin_or_current_user?
    user.admin? or record.id == user.id
  end
end
