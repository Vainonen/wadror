module RatingAverage
  def rating_average
    "Has #{ratings.count} #{"rating".pluralize(ratings.count)}, average #{ratings.average(:score)}"
  end
end
