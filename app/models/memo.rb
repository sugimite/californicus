# == Schema Information
#
# Table name: memos
#
#  id               :bigint           not null, primary key
#  administrator_id :bigint           not null
#  student_id       :bigint           not null
#  input_date       :date             not null
#  content          :text             not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (administrator_id => administrators.id)
#  fk_rails_...  (student_id => students.id)
#
class Memo < ApplicationRecord
  belongs_to :administrator
  belongs_to :student
  
  validates :input_date, presence: true
  validates :content, presence: true
end
