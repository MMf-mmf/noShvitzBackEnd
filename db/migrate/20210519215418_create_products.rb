class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :company
      t.string :image
      t.integer :category_id
      t.float :price
      t.integer :limit
      t.timestamps
    end
  end
end
