class Recipe < ApplicationRecord
  has_many :recipe_images, dependent: :destroy
  accepts_nested_attributes_for :recipe_images
  has_many :bookmarks, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :recipe_reviews,dependent: :destroy
  has_many :materials, dependent: :destroy
  accepts_nested_attributes_for :materials
  enum human: { 一人分: 0, 二人分: 1 ,三人分: 2, 四人分: 3 }
  belongs_to :user
  belongs_to :genre
  belongs_to :category
  ratyrate_rateable "recipe"

  validates :name, presence: true
  validates :content, presence: true
  validates :recipe_images, presence: true
  validates :name,  length: { maximum: 30 }
  validates :content,  length: { maximum: 2000 }




  def create_notification_recipe_review(current_user, recipe_review_id)
    #distinctメソッド=重複レコードを1つにまとめる
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = RecipeReview.select(:user_id).where(recipe_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_recipe_review!(current_user, recipe_review_id, temp_id['user_id'])
    end
    # 投稿者に通知を送る(1回目)
    save_notification_recipe_review!(current_user, recipe_review_id, user_id) if temp_ids.blank?
  end
  def save_notification_recipe_review!(current_user, recipe_review_id, visited_id)
    notification = current_user.active_notifications.new(
      recipe_id: id,
      recipe_review_id: recipe_review_id,
      visited_id: visited_id,
      action: 'recipe_review'
    )
        if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end


  # すでに「ブックマーク」されているか検索,?はスペースホルダー、
  def create_notification_bookmark!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and recipe_id = ? and action = ? ", current_user.id, user_id, id, 'bookmark'])
    #ブックマークされてないなら実行
      if temp.blank?
    notification = current_user.active_notifications.new(
      recipe_id: id,
      visited_id: user_id,
      action: 'bookmark'
    )
    # 自分の投稿に対するブックマークしてる場合は、通知済みとする（1度しか相手に通知が行かない）
        if notification.visitor_id == notification.visited_id
            notification.checked = true
        end
          notification.save if notification.valid?
      end
  end

  def bookmark_by?(user)
      self.bookmarks.where(user_id: user.id).exists?
  end
end
