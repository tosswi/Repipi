class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  attachment :image
  has_many :notifications, dependent: :destroy
  validates :content, presence: true
  scope :recent, -> { order(created_at: :desc)}

  def save_notification_message!(current_user, message_id, visitor_id)
    notification = current_user.active_notifications.new(
      message_id: message_id,
      visitor_id: visitor_id,
      action: 'message'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    notification.save if notification.valid?
  end
end
