class Memo < ApplicationRecord
  belongs_to :administrator
  belongs_to :student
  
  validates :input_date, presence: true
  validates :content, presence: true
end
