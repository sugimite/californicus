class Absence < ApplicationRecord
  belongs_to :student

  validates :absent_on, presence: true
end
