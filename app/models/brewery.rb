class Brewery < ActiveRecord::Base
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers
  include RatingAverage

  validates :year, numericality: { greater_than_or_equal_to: 1042,
                                    less_than_or_equal_to: 2015,
                                    only_integer: true }
  validates :name, length: { minimum: 1 }
  validate :year_cannot_be_in_the_future

  def year_cannot_be_in_the_future
    if year < Time.now.year
      errors.add(:expiration_date, "can't be in the future")
    end
  end

  def print_report
    puts name
    puts "established at year #{year}"
    puts "number of beers #{beers.count}"
    end

  def restart
    self.year = 2015
    puts "changed year to #{year}"
  end

end
