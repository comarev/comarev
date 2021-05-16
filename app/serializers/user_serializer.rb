class UserSerializer < ActiveModel::Serializer
  attributes :id,
    :full_name,
    :email,
    :cpf,
    :address,
    :cellphone,
    :picture_url,
    :admin,
    :active,
    :created_at,
    :updated_at
end
