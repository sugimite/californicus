class Attendance < ApplicationRecord
  belongs_to :administrator
  belongs_to :student

  validates :administrator_id, presence: true
  validates :student_id,  presence: true
  validates :attended_date, presence: true

end
