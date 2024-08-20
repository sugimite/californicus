class Announcement < ApplicationRecord
  has_many :announcement_students, dependent: :destroy
  belongs_to :administrator
  has_many :students, through: :announcement_students

  validates :title, presence: true
  validates :content, presence: true
  validates :start_date, presence: true
  validate :start_date_before_end_date

  scope :active, -> { where("end_date IS NULL OR end_date > ?", Date.today) }

  private

  def start_date_before_end_date
    if end_date.present? && start_date.present? && start_date >= end_date
      errors.add(:start_date, " must be before the end date")
    end
  end
end
