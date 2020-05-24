class Notification < ApplicationRecord
  # デフォルトの並び順を「作成日時の降順」で指定
  default_scope -> { order(created_at: :desc) }
  belongs_to :recipe, optional: true
  belongs_to :recipe_review, optional: true
  belongs_to :message, optional: true
  # visitor_id : 通知を送ったユーザーのid  visited_id : 通知を送られたユーザーのid
  belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true
end

