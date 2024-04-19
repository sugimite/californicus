class CreateMemos < ActiveRecord::Migration[7.0]
  def change
    create_table :memos do |t|
      t.references :administrator, null:false, foreign_key: true
      t.references :student, null: false, index: false, foreign_key: true
      t.date :input_date, null: false
      t.text :content, null: false

      t.timestamps
    end

    add_index :memos, :input_date, name: 'index_memos_on_input_date' unless index_exists?(:memos, :input_date)
    add_index :memos, :administrator_id, name: 'index_memos_on_administrator_id' unless index_exists?(:memos, :administrator_id)
    add_index :memos, [:student_id, :input_date], name: 'index_memos_on_student_id_and_input_date' unless index_exists?(:memos, [:student_id, :input_date])
  end
end
