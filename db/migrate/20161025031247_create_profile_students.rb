class CreateProfileStudents < ActiveRecord::Migration
  def change
    create_table :profile_students do |t|
      t.string :nis
      t.string :student_class
      t.string :first_name
      t.string :last_name
      t.date :born
      t.string :gender
      t.string :province
      t.string :city
      t.string :phone
      t.text :address
      t.string :parent_name
      t.string :parent_address
      t.string :parent_contact
      t.string :parent_job
      t.integer :user_id

      t.timestamps null: false
    end

    add_index :profile_students, :user_id
  end
end
