class CreateRecipeReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :recipe_reviews do |t|

      t.timestamps
    end
  end
end
