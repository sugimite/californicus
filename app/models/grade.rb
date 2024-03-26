class Grade < ApplicationRecord
  belongs_to :student

  SUBJECT_TYPES = %w[ 英語 数学 国語 社会 理科].freeze

  validates :id, uniqueness: { scope: :student_id }
  validates :student_id, presence: true
  validates :year, presence: true
  validates :score, presence: true
  validates :score, numericality: {in: 0..100}
  validates :subject_type, presence: true
  validates :subject_type, inclusion: {in: SUBJECT_TYPES, allow_blank: true}
  validates :test_type, presence: true
end
