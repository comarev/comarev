class DiscountRequestSerializer < ActiveModel::Serializer
  attributes :id, :company_id, :user_id, :received_discount, :created_at, :updated_at
end
