class CreateAdministrators < ActiveRecord::Migration[7.0]
  def change
    create_table :administrators do |t|
      t.string :password_digest
      t.string :code

      t.timestamps
    end
    add_index :administrators, :code, unique: true
  end
end
