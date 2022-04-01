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
    :self_registered,
    :created_at,
    :updated_at

  attribute(:companies) do
    object.company_users.map do |cu|
      { role: cu.role, company: cu.company }
    end
  end
end
