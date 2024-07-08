class CreateAttendances < ActiveRecord::Migration[7.0]
  def change
    create_table :attendances do |t|
      t.references :student, null: false, index: false, foreign_key: true
      t.references :administrator, null: false, index: false, foreign_key: true
      t.date :attended_date, null: false
      t.datetime :in_at, null: false
      t.datetime :out_at 
      t.string :staying_time
      t.boolean :is_with_no_phone

      t.timestamps
    end

  end
end
