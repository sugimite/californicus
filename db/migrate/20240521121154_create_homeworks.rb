class CreateHomeworks < ActiveRecord::Migration[7.0]
  def change
    create_table :homeworks do |t|
      t.references :student, null: false, index: false, foreign_key: true
      t.references :administrator, null: false, index: false, foreign_key: true
      t.string :homework_type, null: false
      t.string :page, null: false
      t.date :assigned_date, null: false
      t.date :deadline
      t.boolean :is_submitted, default: false

      t.timestamps
    end
  end
end
