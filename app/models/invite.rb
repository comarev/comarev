class Invite < ApplicationRecord
  belongs_to :inviter, class_name: "User"
  has_secure_token :invitation_token

  validates :invited_email, presence: true, uniqueness: { scope: :inviter }

  scope :not_expired, -> { where('updated_at > ?', 30.days.ago) }
  scope :available, -> { not_expired.where(replied_at: nil) }
end
