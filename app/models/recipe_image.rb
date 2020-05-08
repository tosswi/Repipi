class RecipeImage < ApplicationRecord
  belongs_to :recipe
  mount_uploader :recipe_image, RecipeImageUploader
end
