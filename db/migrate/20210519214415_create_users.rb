class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.bigint :phoneNumber1
      t.bigint :phoneNumber2
      t.string :address
      t.boolean :activated, default: false
      t.boolean :suspended, default: false
      t.boolean :admin, default: false
      t.boolean :employee, default: false
      t.string :password
      t.string :password_digest
      t.string :remember_digest
      t.string :activation_digest
      t.datetime :activated_at
      t.string :reset_digest
      t.datetime :reset_sent_at
     

      t.timestamps
    end
  end
end
