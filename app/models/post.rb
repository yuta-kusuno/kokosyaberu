class Post < ApplicationRecord
  belongs_to :user
  
  validates :content, :datetime, :place, presence: true, length:{maximum: 255}
end
