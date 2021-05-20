class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :company
      t.integer :category_id
      t.float :weight
      t.float :price

      t.timestamps
    end
  end
end
