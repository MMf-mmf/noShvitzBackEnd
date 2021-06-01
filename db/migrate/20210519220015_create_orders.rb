class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :employee_id
      t.integer :category_id
      t.float :total
      t.string :notes
      t.boolean :fulfilled
      t.boolean :cart
      t.boolean :submitted

      t.timestamps
      
    end
  end
end
