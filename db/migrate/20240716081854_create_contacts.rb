class CreateContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :contacts do |t|
      t.references :administrator
      t.references :student, null: false
      t.text :message, null: false
      t.datetime :date, null: false
      t.boolean :is_from_parents, null: false

      t.timestamps
    end
  end
end
