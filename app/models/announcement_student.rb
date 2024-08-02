class AnnouncementStudent < ApplicationRecord
  belongs_to :announcement
  belongs_to :student

  validates :announcement_id, presence: true
  validates :student_id, presence: true
  validates :announcement_id, uniqueness: { scope: :student_id, message: "この生徒いは既に通知しています。"}
end
