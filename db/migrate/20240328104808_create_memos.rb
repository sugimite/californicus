class CreateMemos < ActiveRecord::Migration[7.0]
  def change
    create_table :memos do |t|
      t.references :administrator, null:false, foreign_key: true
      t.references :student, null: false, index: false, foreign_key: true
      t.date :input_date, null: false
      t.text :content, null: false

      t.timestamps
    end

    add_index :memos, :input_date
    add_index :memos, :administrator_id
    add_index :memos, [ :student_id, :input_date ]
  end
end
