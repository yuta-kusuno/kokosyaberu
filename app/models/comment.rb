class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  
  has_many :notifications, dependent: :destroy
  
  validates :body, presence: true
  validates :user_id, presence: true
  
end
