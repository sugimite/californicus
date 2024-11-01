class CreateAbsences < ActiveRecord::Migration[7.0]
  def change
    create_table :absences do |t|
      t.references :student, null: false, foreign_key: true
      t.integer :count
      t.date :absent_on

      t.timestamps
    end
  end
end
