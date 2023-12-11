class AddPositionToProduct < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :position, :integer
  end
end
