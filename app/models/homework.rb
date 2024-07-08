# == Schema Information
#
# Table name: homeworks
#
#  id               :bigint           not null, primary key
#  student_id       :bigint           not null
#  administrator_id :bigint           not null
#  homework_type    :string           not null
#  page             :string           not null
#  assigned_date    :date             not null
#  deadline         :date
#  is_submitted     :boolean          default(FALSE)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (administrator_id => administrators.id)
#  fk_rails_...  (student_id => students.id)
#
class Homework < ApplicationRecord
  belongs_to :administrator
  belongs_to :student

  HOMEWORK_TYPES = %w[ 英語精選 英語ワーク 数学精選 数学ワーク 国語ワーク 社会ワーク 理科ワーク 算数コア 国語コア 算数ワーク 国語ワーク].freeze

  validates :administrator_id, presence: true
  validates :student_id, presence: true
  validates :homework_type, presence: true, inclusion: { in: HOMEWORK_TYPES }
  validates :page, presence: true
  validates :assigned_date, presence: true
  validate :deadline_after_assigned_date

  private
  def deadline_after_assigned_date
    if deadline.present? && assigned_date.present? && deadline <= assigned_date
      errors.add(:deadline, "提出日は発表日より後の日付でないといけません。")
    end
  end
end
