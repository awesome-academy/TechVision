class Topic < ApplicationRecord
  has_many :reviews, dependent: :destroy
  validates :name, presence: true, length: {maximum: Settings.topic_length}
end
