class AddPublishDateToProduct < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :publish_date, :datetime
  end
end
