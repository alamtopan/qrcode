class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.integer :user_id
      t.string :code
      t.string :name
      t.string :schedule
      t.string :status, default: 'pending'
      t.integer :price, default: 0

      t.timestamps null: false
    end

    add_index :courses, :user_id
  end
end
