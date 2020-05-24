class Genre < ApplicationRecord
  has_many :recipes, dependent: :destroy
  validates :name,length: { maximum: 15 }, presence: true
end
