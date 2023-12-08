class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.string :serial
      t.string :recipient
      t.string :address
      t.string :tel
      t.string :state
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
