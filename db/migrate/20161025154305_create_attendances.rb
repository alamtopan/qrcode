class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.integer :user_id
      t.string :status

      t.timestamps null: false
    end

    add_index :attendances, :user_id
  end
end
