class HashtagDetail < ApplicationRecord
  belongs_to :hashtag
  belongs_to :review
  accepts_nested_attributes_for :hashtag
  validates :hashtag_id, presence: true  
  validates :review_id, presence: true  
end
