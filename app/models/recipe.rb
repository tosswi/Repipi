class Recipe < ApplicationRecord
  attachment :image
  has_many :bookmarks, dependent: :destroy
  has_many :notifications,dependent: :destroy
  has_many :recipe_reviews,dependent: :destroy
  belongs_to :genre
  belongs_to :category
end
