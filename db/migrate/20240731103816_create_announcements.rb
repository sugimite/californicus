class CreateAnnouncements < ActiveRecord::Migration[7.0]
  def change
    create_table :announcements do |t|
      t.references :administrator, null: false, foreign_key: true
      t.string :title, null: false
      t.text :content, null: false
      t.date :start_date, null: false
      t.date :end_date

      t.timestamps
    end
  end
end
