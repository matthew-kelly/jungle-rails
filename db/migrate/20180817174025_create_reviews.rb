class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      # t.integer :product_id
      # t.integer :user_id
      t.references :product, foreign_key: true
      t.references :user, foreign_key: true
      t.text :description
      t.integer :rating

      t.timestamps null: false
    end
    add_index :reviews, :user_id
    add_index :reviews, :product_id
  end
end
