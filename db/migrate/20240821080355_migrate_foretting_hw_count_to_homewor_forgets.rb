class MigrateForettingHwCountToHomeworForgets < ActiveRecord::Migration[7.0]
  def up
    Student.find_each do |student|
      if student.forgetting_hw_count.present? && student.forgetting_hw_count > 0
        HomeworkForget.create!(
          student_id: student.id,
          count: student.forgetting_hw_count,
          year: Date.current_year
        )
      end
    end
  end

  def down
    HomeworkForget.delete_all
  end
end
