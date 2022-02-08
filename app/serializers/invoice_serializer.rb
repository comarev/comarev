class InvoiceSerializer < ActiveModel::Serializer
  attributes :id,
    :user_id,
    :amount,
    :paid,
    :status,
    :due_date,
    :created_at,
    :updated_at

  belongs_to :user
end
