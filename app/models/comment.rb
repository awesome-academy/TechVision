class Comment < ApplicationRecord
  belongs_to :review
  belongs_to :user
  scope :comment_time, -> {order(created_at: :desc).limit(5)}
  validates :review_id,  presence: true
  validates :user_id,    presence: true
  validates :content,    presence: true
end
