class Movie < ActiveRecord::Base
	
	def self.list_rating
		ratings = []
		Movie.all.each{|x| ratings << x.rating}
		return ratings.uniq.sort
	end
	
end
