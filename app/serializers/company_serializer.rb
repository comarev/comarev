class CompanySerializer < ActiveModel::Serializer
  attributes :id,
    :name,
    :address,
    :cnpj,
    :phone,
    :code,
    :discount,
    :active,
    :created_at,
    :updated_at
end
