class Memo < ApplicationRecord
  belongs_to :student, class_name: "Student"
  
  validates :input_date, presence: true
  validates :content, presence: true
end
