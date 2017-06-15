class CreateConfirmations < ActiveRecord::Migration
  def change
    create_table :confirmations do |t|
      t.string :invoice_code
      t.integer :user_id
      t.integer :course_id
      t.date :payment_date
      t.integer :nominal
      t.string :bank_account
      t.string :payment_method
      t.string :sender_name
      t.string :status, default: 'pending'

      t.timestamps null: false
    end

    add_index :confirmations, :user_id
    add_index :confirmations, :course_id
  end
end
