class Invite < ApplicationRecord
  belongs_to :inviter, class_name: "User"
  belongs_to :company
  has_secure_token :invitation_token

  validates :invited_email, presence: true

  scope :not_expired, -> { where('updated_at > ?', 30.days.ago) }
  scope :available, -> { not_expired.where(replied_at: nil) }

  scope :refused, -> { where(accepted: false) }
  scope :recently_refused, -> { refused.where('replied_at > ?', 10.minutes.ago) }

  def refuse
    self.update_columns(replied_at: Time.current, accepted: false)
  end

  def accept
    if invited_user = User.find_by(email: invited_email)
      CompanyUser.create(user_id: invited_user.id, company_id: company.id, role: 'regular')
      self.update_columns(replied_at: Time.current, accepted: true)
    end
  end
end
