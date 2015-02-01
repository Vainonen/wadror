class User < ActiveRecord::Base
  has_many :ratings, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :beer_clubs, through: :memberships
  validates :username, uniqueness: true,
            length: { minimum: 3, maximum: 15 }
  validates :password, length: { minimum: 4 },
            format: { with: /[A-Z]/, allow_blank: true }

  include RatingAverage

  has_secure_password

end
