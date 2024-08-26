class AddSchoolYearToHomeworkForgets < ActiveRecord::Migration[7.0]
  def change
    add_column :homework_forgets, :school_year, :integer, null: false
  
    HomeworkForget.reset_column_information
  
    HomeworkForget.find_each do |homework_forget|
      school_year = determine_school_year(homework_forget.forgetted_on)
      homework_forget.update_column(:school_year, school_year)
    end
  end
  
  private
  
  def determine_school_year(forgetted_on)
    if forgetted_on.month >= 3
      forgetted_on.year
    else
      forgetted_on.year - 1
    end
  end
end
  