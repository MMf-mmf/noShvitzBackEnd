class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|
      t.integer :order_id
      t.integer :product_id
      t.integer :status_code
      t.integer :quantity
      t.integer :price
      t.float :weight

      t.timestamps
    end
  end
end
