class User < ApplicationRecord
  devise :database_authenticatable, :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  has_one_attached :profile_picture

  validates_uniqueness_of :email

  validates :email, presence: true
  validates :full_name, presence: true
  validates :cellphone, presence: true
  validates :address, presence: true
  validates :cpf, presence: true

  def picture_url
    return nil unless profile_picture.attached?

    profile_picture.service_url
  end
end
