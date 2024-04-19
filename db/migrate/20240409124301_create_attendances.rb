class CreateAttendances < ActiveRecord::Migration[7.0]
  def change
    create_table :attendances do |t|
      t.references :student, null: false, foreign_key: true
      t.references :administrator, null: false, foreign_key: true
      t.date :attended_date, null: false
      t.datetime :in_at, null: false
      t.datetime :out_at 
      t.string :staying_time
      t.boolean :is_with_no_phone

      t.timestamps
    end

    remove_index :attendances, :student_id if index_exists?(:attendances, :student_id)
    add_index :attendances, :student_id, name: "index_attendances_on_new_student_id"
    
    remove_index :attendances, :administrator_id if index_exists?(:attendances, :administrator_id)
    add_index :attendances, :administrator_id, name: "index_attendances_on_new_administrator_id"

    add_index :attendances, :attended_date, name: "index_attendances_on_attended_date"
    add_index :attendances, :in_at, name: "index_attendances_on_in_at"
  end
end
