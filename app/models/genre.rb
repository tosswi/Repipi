class Genre < ApplicationRecord
  has_many :recipes, dependent: :destroy
end
