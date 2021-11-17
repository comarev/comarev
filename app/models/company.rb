class Company < ApplicationRecord
  validates :name, :cnpj, :code, :active, presence: true
  validates :cnpj, :code, uniqueness: { case_sensitive: false }

  has_many :company_users, dependent: :destroy
  has_many :users, through: :company_users
end
