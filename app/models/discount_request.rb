class DiscountRequest < ApplicationRecord
  belongs_to :user
  belongs_to :company

  validates :received_discount, presence: true
  validates :allowed, inclusion: { in: [true, false] }
end
