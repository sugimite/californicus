class CreateAnnouncementStudents < ActiveRecord::Migration[7.0]
  def change
    create_table :announcement_students do |t|
      t.references :announcement, null: false, index: false, foreign_key: true
      t.references :student, null: false, index: false, foreign_key: true

      t.timestamps
    end
  end
end
