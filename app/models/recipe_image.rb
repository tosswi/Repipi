class RecipeImage < ApplicationRecord
  belongs_to :recipe
  mount_uploader :image_url, RecipeImageUploader
end
