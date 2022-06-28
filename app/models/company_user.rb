class CompanyUser < ApplicationRecord
  belongs_to :company
  belongs_to :user

  enum role: { regular: 0, manager: 1 }
end
