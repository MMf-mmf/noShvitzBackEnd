class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :ghoneNumber1
      t.integer :ghoneNumber2
      t.string :address
      t.bullion :activated
      t.bullion :suspended
      t.bullion :admin
      t.bullion :employee
      t.string :password
      t.string :password_digest

      t.timestamps
    end
  end
end
