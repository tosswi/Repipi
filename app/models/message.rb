class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  validates :content, presence: true
  scope :recent, -> { order(created_at: :desc)}
end
