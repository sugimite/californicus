class CreateHomeworkForgets < ActiveRecord::Migration[7.0]
  def change
    create_table :homework_forgets do |t|
      t.references :student, null: false, foreign_key: true
      t.date :forgetted_on, null: false
      t.integer :count, default: 1

      t.timestamps
    end
  end
end
