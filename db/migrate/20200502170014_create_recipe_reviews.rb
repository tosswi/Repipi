class CreateRecipeReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :recipe_reviews do |t|
      t.text :recipe_comment

      t.integer :user_id
      t.integer :recipe_id

      t.timestamps
    end
  end
end
