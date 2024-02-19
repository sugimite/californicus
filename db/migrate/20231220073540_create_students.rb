class CreateStudents < ActiveRecord::Migration[7.0]
  def change
    create_table :students do |t|
      t.string :name, null: false
      t.string :name_kana, null: false
      t.date :birthday
      t.string :email, null: false
      t.string :password_digest
      t.date :registration_date, null: false
      t.date :cancellation_date
      t.integer :forgetting_hw_count
      t.boolean :has_deposited_phone

      t.timestamps
    end
    
  end
end
