class CreateLikeProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :like_products do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :product, null: false, foreign_key: true

      # t.timestamps
    end
  end
end
