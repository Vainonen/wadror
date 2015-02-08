class User < ActiveRecord::Base
  has_many :ratings, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :beer_clubs, through: :memberships
  validates :username, uniqueness: true,
            length: { minimum: 3, maximum: 15 }
  validates :password, length: { minimum: 4 }
  validates :password, format: { with: /\d.*[A-Z]|[A-Z].*\d/, message: "has to contain one number and one upper case letter" }



include RatingAverage

  has_secure_password

  def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end

end
