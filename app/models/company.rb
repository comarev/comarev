class Company < ApplicationRecord
  validates :name, :cnpj, :code, presence: true
  validates :cnpj, :code, uniqueness: { case_sensitive: false }
  validates :active, inclusion: { in: [true, false] }

  has_many :company_users, dependent: :destroy
  has_many :users, through: :company_users
end
