class CreateRecipeImages < ActiveRecord::Migration[5.2]
  def change
    create_table :recipe_images do |t|
      t.string :recipe_image
      t.integer :recipe_id

      t.timestamps
    end
  end
end
