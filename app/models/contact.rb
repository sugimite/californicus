class Contact < ApplicationRecord
  belongs_to :administrator, optional: true
  belongs_to :student

  validates :student_id, presence: true
  validates :message, presence: true, length: { maximum: 800 }
  validates :date, presence: true
  validates :is_from_parents, presence: true
end
