class Attendance < ApplicationRecord
  belongs_to :administrator
  belongs_to :student

  before_save :caliculate_staying_time
  before_save :set_out_at_to_nil_if_same_as_in_at

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


  validates :administrator_id, presence: true
  validates :student_id,  presence: true
  validates :attended_date, presence: true

end
