class User < ActiveRecord::Base
  include RatingAverage

  has_secure_password

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships

  scope :active, -> { where active:true }
  scope :retired, -> { where active:[nil,false] }

  validates :username, uniqueness: true,
                       length: { in: 3..15 }

  validates :password, length: { minimum: 4 }

  validates :password, format: { with: /\d.*[A-Z]|[A-Z].*\d/,  message: "has to contain one number and one upper case letter" }

  def favorite(category)
    return nil if ratings.empty?

    category_ratings = rated(category).inject([]) do |set, item|
      set << {
          item: item,
          rating: rating_of(category, item) }
    end

    category_ratings.sort_by { |item| item[:rating] }.last[:item]
  end

  def favorite_brewery
    favorite :brewery
  end

  def favorite_style
    favorite :style
  end

  def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end

  def rated(category)
    ratings.map{ |r| r.beer.send(category) }.uniq
  end

  def rating_of(category, item)
    ratings_of_item = ratings.select do |r|
      r.beer.send(category) == item
    end
    ratings_of_item.map(&:score).sum / ratings_of_item.count
  end

  def self.top(n)
    sorted_by_rating_count_in_desc_order = User.all.sort_by {|u| u.ratings.count}.take(n).reverse
  end

end
