class CreateGrades < ActiveRecord::Migration[7.0]
  def change
    create_table :grades do |t|
      t.references :student, null: false, index: false, foreign_key: true
      t.integer :year, null: false 
      t.integer :score, null: false
      t.string :subject_type, null: false
      t.string :test_type, null: false

      t.timestamps
    end

  end
end
