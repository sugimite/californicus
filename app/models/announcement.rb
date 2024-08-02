class Announcement < ApplicationRecord
  has_many :announcement_students, dependent: :destroy
  belongs_to :administrator
  has_many :students, through: :announcement_students

  validates :title, presence: true
  validates :content, presence: true
  validates :start_date, presence: true
end
