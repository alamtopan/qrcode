class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      t.string :username, unique: true
      t.string :slug
      t.string :type
      t.string :photo
      t.string :status, default: 'pending'

      t.string :first_name
      t.string :last_name
      t.date   :born
      t.string :gender
      t.string :address
      t.string :phone
      t.text   :address
      t.string :parent_name
      t.string :parent_address
      t.string :parent_contact
      
      t.timestamps null: false
    end

    add_index :users, :email, unique: true
  end
end
