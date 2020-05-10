class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable
  enum sex: { 女性: 0, 男性: 1 }
  attachment :image
  has_many :messages
  has_many :recipes
  has_many :recipe_reviews
  has_many :bookmarks
  has_many :bookmark_recipes,through: :bookmarks, source: :recipe
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
  has_many :refrigerator
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user
  ratyrate_rater
  has_many :points
  has_many :sns_credentials, dependent: :destroy
  
  def user_rank_update(user)
    case user.point
    when 0..9
      user.rank = "レギュラー会員"
    when 10..49
      user.rank = "シルバー会員"
    when 49..99
      user.rank = "ゴールド会員"
    when 100..199
      user.rank = "プラチナ会員"
    when 200..999
      user.rank = "ダイアモンド会員"
    end
    user.save
  end



  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end

  def create_notification_follow!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end
 def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    unless user
      user = User.create(
        uid:      auth.uid,
        provider: auth.provider,
        email:    auth.info.email,
        name:  auth.info.name,
        password: Devise.friendly_token[0, 20],
        image:  auth.info.image
      )
      end
    user
  end
  def active_for_authentication?
    super && (self.is_member_status == false)
  end

end
