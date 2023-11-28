class AddUserToProduct < ActiveRecord::Migration[7.1]
  def change
    add_belongs_to :products, :user
  end
end
