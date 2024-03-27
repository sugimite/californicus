class Grade < ApplicationRecord
  belongs_to :student

  SUBJECT_TYPES = %w[ 英語 数学 国語 社会 理科].freeze
  TEST_TYPES = %w[ 1学期中間 1学期期末 2学期中間 2学期期末 学年末 実力1 実力2 実力3 実力4 実力5 ].freeze

  validates :year, presence: true
  validates :score, presence: true
  validates :score, numericality: {in: 0..100, allow_nil: true} 
  validates :subject_type, presence: true
  validates :subject_type, inclusion: {in: SUBJECT_TYPES, allow_blank: true}
  validates :test_type, presence: true
  validates :test_type, inclusion: {in: TEST_TYPES, allow_blank: true}
end
