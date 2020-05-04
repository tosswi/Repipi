class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum sex: { 女性: 0, 男性: 1 }
  attachment :image
  
  has_many :recipes
  has_many :recipe_reviews
  has_many :bookmarks
  has_many :visitors
  has_many :visited
  has_many :refrigerator
end
