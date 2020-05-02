class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.string :name
      t.text :content
      t.text :material
      t.integer :quantity
      t.integer :human
      t.time :playtime
      t.string :image_id
      t.integer :genre_id
      t.integer :user_id
      t.integer :category_id


      t.timestamps
    end
  end
end
