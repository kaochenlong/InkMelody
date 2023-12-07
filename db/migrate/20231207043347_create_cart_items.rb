class CreateCartItems < ActiveRecord::Migration[7.1]
  def change
    create_table :cart_items do |t|
      t.belongs_to :product, null: false, foreign_key: true
      t.integer :quantity, default: 1
      t.belongs_to :cart, null: false, foreign_key: true

      t.timestamps
    end
  end
end
