class User < ApplicationRecord
  devise :database_authenticatable, :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  has_one_attached :profile_picture

  validates :email, uniqueness: true
  validates :email, :full_name, :cellphone, :address, :cpf, presence: true

  def picture_url
    return nil unless profile_picture.attached?

    profile_picture.service_url
  end
end
