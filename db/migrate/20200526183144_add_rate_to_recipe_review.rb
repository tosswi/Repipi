class AddRateToRecipeReview < ActiveRecord::Migration[5.2]
  def change
    add_column :recipe_reviews, :rate, :float, null: false, default: 0
  end
end
