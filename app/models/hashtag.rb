class Hashtag < ApplicationRecord
  has_many :hashtag_details
  has_many :reviews, through: :hashtag_details
  validates :name, presence: true, length: { maximum: Settings.hashtag_length }
  scope :searchHashtag, ->(nameSearch){select(:id, :name).where("name 
  	like ?", "%#{nameSearch}%").limit(Settings.hashtag)}
end
