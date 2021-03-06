class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable, :omniauthable
  enum sex: { 男性: 0, 女性: 1 }
  attachment :image
  has_many :messages, dependent: :destroy
  has_many :recipes, dependent: :destroy
  has_many :recipe_reviews, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  #throughオプションでユーザーがブックマークした投稿を直接アソシエーションで取得
  has_many :bookmark_recipes,through: :bookmarks, source: :recipe, dependent: :destroy
  # Notificationを通してactive_notificationsを使用する
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
  has_many :relationships, dependent: :destroy
  # relationshipsを通してfollowsを使用する
  has_many :followings, through: :relationships, source: :follow, dependent: :destroy
  #ペアで重複するものが保存されないようにする
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id', dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :user, dependent: :destroy
  has_many :sns_credentials, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  validates :name, presence: true
  validates :nickname, presence: true,  length: { maximum: 15 },uniqueness: true
  validates :phone_number, presence: true 
  validates :email,  length: { maximum: 50 }
  
  # userのポイントによるランキング
  def user_rank_update(user)
    case user.point
    when 0..99
      user.rank = "レギュラー会員"
    when 100..299
      user.rank = "シルバー会員"
    when 300..999
      user.rank = "ゴールド会員"
    when 1000..2999
      user.rank = "プラチナ会員"
    when 3000..9999
      user.rank = "ダイアモンド会員"
    end
    user.save
  end

  def follow(other_user)
    #self=自分,身つかなければcreate
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    #other_user.idがfollow_idで見つかれば消す
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end

  def create_notification_follow!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
    #同じ通知レコードが存在しないときだけ、レコードを作成する
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
      end
    end
    
    # userのis_member_statusがfalseならtrueを返す
  def active_for_authentication?
    super && (self.is_member_status == false)
  end


end
