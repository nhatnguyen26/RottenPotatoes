class Movie < ActiveRecord::Base
	scope :order_by, lambda {|col| order("#{col} ASC")}
	
	def self.list_rating
		ratings = []
		Movie.all.each{|x| ratings << x.rating}
		return ratings.uniq.sort
	end
	
	def self.sorting(params)
		if !params[:sort_by].blank?
			movies = Movie.order_by(params[:sort_by])
		else
			movies = Movie.all
		end
	end
end
