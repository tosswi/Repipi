class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.string :name
      t.text :content
      t.text :material
      t.integer :human
      t.time :playtime
      t.integer :genre_id
      t.integer :user_id
      t.integer :category_id
      t.boolean :is_recipe_status ,default: false, null: false

      t.timestamps
    end
  end
end
