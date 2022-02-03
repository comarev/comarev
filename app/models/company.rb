class Company < ApplicationRecord
  validates :name, :cnpj, presence: true
  validates :cnpj, :code, uniqueness: { case_sensitive: false }

  has_many :company_users, dependent: :destroy
  has_many :users, through: :company_users

  has_many :managers,
    -> { where(company_users: { role: :manager }) },
    through: :company_users, source: :user

  has_many :regulars,
    -> { where(company_users: { role: :regular }) },
    through: :company_users, source: :user

  before_validation :assign_code

  private

  def assign_code
    self.code ||= SecureRandom.hex(10)
  end
end
