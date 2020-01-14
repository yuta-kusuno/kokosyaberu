class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 30 }
  validates :apartment, :adress, length: { maximum: 100}
  validates :sex, :age, length: { maximum: 5 }
  validates :introduction, length: { maximum: 100}
  validates :email, presence: true, length: { maximum: 50 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  
  has_secure_password
  mount_uploader :photo, PhotoUploader
  
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  has_many :talks, dependent: :destroy #"参照、この結果をthroughで扱う"
  has_many :own_talks, through: :talks, source: :receive_user, dependent: :destroy 
  has_many :reverses_of_talk, class_name: 'Talk', foreign_key: 'receive_user_id', dependent: :destroy #"参照"
  has_many :opponent_talks, through: :reverses_of_talk, source: :user
  
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visiter_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
  
end
