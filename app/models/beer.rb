class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :ratings, dependent: :destroy
  has_many :raters, through: :ratings, source: :user
  include RatingAverage

  validates :name, length: { minimum: 1 }
  validates :style, length: { minimum: 1 }

  def to_s
    "#{name}"+" "+"#{brewery.name}"
  end
end
