class InvoiceSerializer < ActiveModel::Serializer
  attributes :id,
    :user_id,
    :amount,
    :paid,
    :status,
    :created_at,
    :updated_at
end
