class CompanySerializer < ActiveModel::Serializer
  attributes :id,
    :name,
    :address,
    :cnpj,
    :phone,
    :code,
    :discount,
    :active,
    :users,
    :created_at,
    :updated_at
end
