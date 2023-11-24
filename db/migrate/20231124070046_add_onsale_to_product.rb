class AddOnsaleToProduct < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :onsale, :boolean, default: false
  end
end
