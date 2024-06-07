class CreateMemos < ActiveRecord::Migration[7.0]
  def change
    create_table :memos do |t|
      t.references :administrator, null: false, index: false, foreign_key: true
      t.references :student, null: false, index: false, foreign_key: true
      t.date :input_date, null: false
      t.text :content, null: false

      t.timestamps
    end

  end
end
