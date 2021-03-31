class User < ApplicationRecord
  devise :database_authenticatable, :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  mount_uploader :avatar, AvatarUploader

  validates :email, uniqueness: true
  validates :email, :full_name, :cellphone, :address, :cpf, presence: true

  def picture_url
    return nil unless !avatar.file.nil?

    avatar.url
  end
end
