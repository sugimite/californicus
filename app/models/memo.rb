class Memo < ApplicationRecord
  belongs_to :student, class_name: "Student"
end
