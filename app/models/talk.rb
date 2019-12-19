class Talk < ApplicationRecord
  belongs_to :user
  belongs_to :receive_user, class_name:'User'
  
  has_many :notifications, dependent: :destroy
  
  validates :content, presence: true, length: { maximum:140 }
  
    def save_notification_talk!(current_user, talk_id, visited_id)
      #トークは複数回することが考えられるため、複数回通知する
      notification = current_user.active_notifications.new(
        talk_id: talk_id,
        visited_id: visited_id,
        action: 'talk'
      )
      #自分のトークは、通知済みとする
      if notification.visiter_id == notification.visited_id
        notificaiton.checked = true
      end
      
      if notification.valid?
        notification.save
      end
    end
  
  def create_notification_talk!(current_user, talk_id)
    #自分のトークを取得し、相手に通知を送る
    temp_ids = Talk.select(:user_id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_talk!(current_user, talk_id, temp_id['user_id'])
    end
    if temp_ids.blank?
      save_notification_talk!(current_user, talk_id, user_id)
    end
    
  end

end
