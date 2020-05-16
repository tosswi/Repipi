class Category < ApplicationRecord
  has_many :recipes, dependent: :destroy
end
