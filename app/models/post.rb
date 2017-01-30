class Post < ApplicationRecord
  validates_presence_of :date, :work_performed, :daily_hours
  validates :daily_hours, numericality: { greater_than: 0.0 }
  belongs_to :user
  enum status: {submitted: 0, approved: 1, rejected: 2}

  scope :posts_by, -> (user) { where(user_id: user.id) }

  after_save :confirm_audit_log, if: :submitted?
  after_save :unconfirm_audit_log, if: :rejected?

  private

  def confirm_audit_log
    audit_log = AuditLog.where(user_id: self.user_id, start_date: (self.date - 7.days..self.date)).last
    audit_log.confirmed! if audit_log
  end

  def unconfirm_audit_log
    audit_log = AuditLog.where(user_id: self.user_id, start_date: (self.date - 7.days..self.date)).last
    audit_log.pending! if audit_log
  end
end
