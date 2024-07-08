class CreateContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :contacts do |t|
      t.references :student, null: false, foreign_key: true
      t.integer :contact_id, null: false
      t.text :messages, null: false
      t.string :title, null: false
      t.datetime :date, null: false
      t.boolean :is_from_parents, null: false, default: true

      t.timestamps
    end
  end
end
