class User < ApplicationRecord
  devise :database_authenticatable, :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  mount_uploader :avatar, AvatarUploader

  validates :email, :cpf, uniqueness: true
  validates :email, :full_name, :cellphone, :address, :cpf, presence: true

  has_many :company_users, dependent: :destroy
  has_many :companies, through: :company_users

  def picture_url
    return nil if avatar.file.nil?

    avatar.url
  end

  def company_user_for(company_id)
    company_users.find_by(company_id: company_id)
  end
end
