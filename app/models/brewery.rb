class Brewery < ActiveRecord::Base
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers
  include RatingAverage

  validates :year, numericality: { greater_than_or_equal_to: 1024,
                                   less_than_or_equal_to: ->(_){Time.now.year} }
  validates :name, length: { minimum: 1 }

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
