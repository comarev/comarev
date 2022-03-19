class DiscountRequestSerializer < ActiveModel::Serializer
  attributes :id, :company_id, :user, :received_discount, :created_at, :updated_at, :allowed
end
