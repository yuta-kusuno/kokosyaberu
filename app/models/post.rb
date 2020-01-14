class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
  
  validates :content, presence: true, length:{maximum: 255}
  validates :datetime, :place, length:{maximum: 30}
  
  def save_notification_comment!(current_user, comment_id, visited_id)
    #コメントは複数回することが考えられるため、一つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      post_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    #自分の投稿に対するコメントは、通知済みとする
    if notification.visiter_id == notification.visited_id
      notificaiton.checked = true
    end
    
    if notification.valid?
      notification.save
    end
  end
  
  def create_notification_comment!(current_user, comment_id)
    #自分以外のコメントしている人を全て取得し、全員に通知を送る
    temp_ids = Comment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    #まだ誰もコメントしていない場合は、投稿者に通知を送る
    if temp_ids.blank?
      save_notification_comment!(current_user, comment_id, user_id)
    end
  end
  
end
