class Company < ApplicationRecord
  validates :name, :cnpj, :active, presence: true
  validates :cnpj, uniqueness: true
end
