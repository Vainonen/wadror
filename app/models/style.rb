class Style < ActiveRecord::Base
  include RatingAverage
  has_many :beers
  has_many :ratings, through: :beers

  def to_s
    name
  end

  def self.top(n)
    st = Style.all.select { |s| !s.average_rating.nan? }
    sorted_by_rating_in_desc_order = st.sort_by { |s| -(s.average_rating||0) }.take(n)
  end
end
