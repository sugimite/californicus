class AddAdministratorRefToMemos < ActiveRecord::Migration[7.0]
  def change
    add_reference :memos, :administrator, null: false, foreign_key: true
  end
end
