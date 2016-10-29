class CreateProfileTeachers < ActiveRecord::Migration
  def change
    create_table :profile_teachers do |t|
      t.string :nik
      t.string :first_name
      t.string :last_name
      t.date :born
      t.string :gender
      t.string :province
      t.string :city
      t.string :phone
      t.text :address
      t.integer :user_id
      t.string :teacher_class

      t.timestamps null: false
    end

    add_index :profile_teachers, :user_id
  end
end
