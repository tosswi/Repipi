class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  attachment :image
  has_many :notifications, dependent: :destroy
  validates :content,length: { maximum: 1000 } ,presence: true
  scope :recent, -> { order(created_at: :desc)}

  # DMが届いたら通知
  def save_notification_message!(current_user, message_id, visited_id)
    notification = current_user.active_notifications.new(
      visitor_id: current_user,
      message_id: message_id,
      visited_id: visited_id,
      action: 'message'
    )
    # 自分の投稿に対するメッセージの場合は、通知済みとする
    notification.save if notification.valid?
  end
end
