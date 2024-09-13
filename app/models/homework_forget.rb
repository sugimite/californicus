class HomeworkForget < ApplicationRecord
  belongs_to :student

  validates :forgetted_on, presence: true
  validates :count, numericality: { greater_than_or_equal_to: 1 }

  before_save :set_school_year

  private

  def set_school_year
    self.school_year = determine_school_year(forgetted_on)
  end

  def determine_school_year(forgetted_on)
    if forgetted_on.month >= 3
      forgetted_on.year
    else
      forgetted_on.year - 1
    end
  end
end
