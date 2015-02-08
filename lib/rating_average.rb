module RatingAverage
  def rating_average
    ratings.map(&:score).sum.to_f/ratings.count
  end
end
