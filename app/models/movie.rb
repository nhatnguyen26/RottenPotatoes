class Movie < ActiveRecord::Base
	scope :order_by, lambda {|col| order("#{col} ASC")}
	
	def self.sorting(params)
		if !params[:sort_by].blank?
			movies = Movie.order_by(params[:sort_by])
		else
			movies = Movie.all
		end
	end
end
