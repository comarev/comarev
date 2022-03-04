class Company < ApplicationRecord
  validates :name, :cnpj, presence: true
  validates :cnpj, :code, uniqueness: { case_sensitive: false }
  validates :cnpj, length: { is: 14 }
  validates :phone, length: { is: 14 }

  mount_uploader :avatar, AvatarUploader

  has_many :company_users, dependent: :destroy
  has_many :users, through: :company_users
  has_many :discount_requests, dependent: :destroy

  has_many :managers,
    -> { where(company_users: { role: :manager }) },
    through: :company_users, source: :user

  has_many :regulars,
    -> { where(company_users: { role: :regular }) },
    through: :company_users, source: :user

  before_validation :assign_code

  def picture_url
    return nil if avatar.file.nil?

    avatar.url
  end

  private

  def assign_code
    self.code ||= SecureRandom.hex(10)
  end
end
