class Review < ApplicationRecord
  belongs_to :user
  belongs_to :topic
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :hashtag_details, dependent: :destroy
  has_many :hashtags, through: :hashtag_details
  has_many  :comments, dependent: :destroy
  has_many  :bookmarks, dependent: :destroy
  has_many :reports, dependent: :destroy
  has_one_attached :image
  delegate :name, :to => :topic, :allow_nil => true
  accepts_nested_attributes_for :hashtag_details, allow_destroy: true
  enum appended: { waitting: false, approved: true }
  scope :all_review, -> { order created_at: :desc }
  scope :approval, -> {where appended: true}
  scope :hot, -> {where(hot: true).order(created_at: :desc).limit(Settings.hot)}
  scope :reviewNew, -> {order(created_at: :desc).limit(Settings.reviews)}
  scope :searchReview, ->(title){select(:title, :id).where("title like ?",
   "%#{title}%").limit(5)}
  scope :searchListReview, ->(parameter){where("lower(title)
    LIKE :search", search: "%#{parameter}%")}
  scope :topLikes1, -> {Review.joins("INNER JOIN (select review_id,
    count(user_id) as total from likes group by review_id order by
    total desc limit 5) a ON reviews.id = a.review_id").order("total DESC")}
  scope :reviewRelate, ->  (idReview){Review.joins("INNER JOIN (select
    hashtag_id, from hashtag_details where review_id = #{idReview})
    a ON reviews.id = a.review_id limit 5")}
  idHashtags = "select hashtag_id from hashtag_details where review_id = ?"
  idReviews = "select review_id from hashtag_details where hashtag_id in(#{idHashtags}) and review_id <> ?"
  scope :reviewHashtag, -> (id){Review.where("id in(#{idReviews})", id, id).limit(Settings.review_hashtag)}
  scope :all_appended_false, -> { where appended: false }

	validates :user_id, presence: true
	validates :content, presence: true, length: { maximum: Settings.review_length }
  validates :image, content_type: { in: %w[image/jpeg image/gif image/png image/jpg],
                                           message: "must be a valid image format" },
                    size: { less_than: 5.megabytes,
                            message: "should be less than 5MB " }
  def display_image
    image.variant(resize_to_limit: [500, 500])
  end
end

