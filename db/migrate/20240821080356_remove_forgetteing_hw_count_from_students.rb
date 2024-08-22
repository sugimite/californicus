class RemoveForgetteingHwCountFromStudents < ActiveRecord::Migration[7.0]
  def change
    remove_column :students, :forgetting_hw_count, :integer
  end
end
