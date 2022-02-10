class CompanySerializer < ActiveModel::Serializer
  attributes :id,
    :name,
    :address,
    :cnpj,
    :phone,
    :picture_url,
    :code,
    :discount,
    :active,
    :created_at,
    :updated_at

  has_many :managers, serializer: UserSerializer
  has_many :regulars, serializer: UserSerializer
end
