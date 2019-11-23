class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :sex, length: { maximum: 10 }
  validates :age, length: { maximum: 10 }
  validates :introduction, length: { maximum: 500}
  validates :adress, presence: true, length: { maximum: 500 }
  validates :apartment, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  
  has_secure_password
  has_many :posts
  
  has_many :talks #"参照、この結果をthroughで扱う"
  has_many :own_talks, through: :talks, source: :receive_user 
  has_many :reverses_of_talk, class_name: 'Talk', foreign_key: 'receive_user_id' #"参照"
  has_many :opponent_talks, through: :reverses_of_talk, source: :user
  
  mount_uploader :photo, PhotoUploader

end
