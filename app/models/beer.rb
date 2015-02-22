class Beer < ActiveRecord::Base
  include RatingAverage

  belongs_to :style
  belongs_to :brewery
  has_many :ratings, dependent: :destroy
  has_many :raters, -> { uniq }, through: :ratings, source: :user

  validates :name, presence: true
  validates :style, presence: true

  def to_s
    "#{name} #{brewery.name}"
  end

  def self.top(n)
    br = Beer.all.select { |b| !b.average_rating.nan? }
    sorted_by_rating_in_desc_order = br.sort_by { |b| -(b.average_rating||0) }.take(n)
  end
end
