class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  
  has_many :notifications, dependent: :destroy
  
  validates :body, presence: true, length: { maximum:140 }
  validates :user_id, presence: true
  
end
