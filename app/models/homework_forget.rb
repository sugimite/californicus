class HomeworkForget < ApplicationRecord
  belongs_to :student

  validates :forgetted_on, presence: true
  validates :count, numericality: { greater_than_or_equal_to: 1 }
end
