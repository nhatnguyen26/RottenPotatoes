class MoviesController < ApplicationController
  
  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
	@all_ratings = Movie.list_rating
	@filter = []
	@movies = []
	if !params[:sort_by].nil?
		#@movies = Movie.find(:all, :order => "#{params[:sort_by]} ASC");
	
		if !params[:ratings].nil?
			@filter = params[:ratings].keys
			Movie.find(:all, :order => "#{params[:sort_by]} ASC").each do |movie|
			if @filter.include?(movie.rating)
				@movies << movie
			end
			end
		else
			@movies = Movie.find(:all, :order => "#{params[:sort_by]} ASC")
		end
	else
		if !params[:ratings].nil?
			@filter = params[:ratings].keys
			Movie.find(:all).each do |movie|
			if @filter.include?(movie.rating)
				@movies << movie
			end
			end
		else
			@movies = Movie.all
		end
	end
	
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
