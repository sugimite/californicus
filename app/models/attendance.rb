class Attendance < ApplicationRecord
  belongs_to :administrator
  belongs_to :student

  before_save :caliculate_staying_time
  before_validation :set_out_at_to_nil_if_same_as_in_at

  private 
  def caliculate_staying_time
    if in_at.present? && out_at.present?
      staying_time_seconds = (out_at - in_at).to_i
      staying_time_hours = staying_time_seconds / 3600
      staying_time_minutes = (staying_time_seconds % 3600) / 60
      self.staying_time = "#{staying_time_hours}時間 #{staying_time_minutes}分"
    end
  end

  def set_out_at_to_nil_if_same_as_in_at
    self.out_at = nil if in_at == out_at
  end

  validate :out_at_should_be_later_than_in_at

  private

  def out_at_should_be_later_than_in_at
    if out_at && in_at && out_at <= in_at
      errors.add(:out_at, "離席時間は出席時間よりも遅くなければなりません")
    end
  end
  

  validates :administrator_id, presence: true
  validates :student_id,  presence: true
  validates :attended_date, presence: true
  validates :in_at, presence: true
end
