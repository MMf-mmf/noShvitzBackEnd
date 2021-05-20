class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :product_id
      t.float :total
      t.string :notes
      t.bullion :completed
      t.timestamps
      
    end
  end
end
