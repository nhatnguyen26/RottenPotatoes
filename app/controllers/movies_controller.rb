class MoviesController < ApplicationController
  
  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
	session.clear
	if params[:sort_by].nil? && params[:ratings].nil?
		redirect_to(:action => "index")
	end
	@all_ratings = Movie.list_rating
	@filter = []
	@movies = []
	
	if !params[:ratings].nil?
		@filter = params[:ratings].keys
		Movie.find(:all, :order => "#{params[:sort_by]}").each{|x| @movies << x if params[:ratings].keys.include?(x.rating)}
	else
		@movies = Movie.find(:all, :order => "#{params[:sort_by]}")
	end
	
	session[:sort_by] = params[:sort_by]
	session[:ratings] = params[:ratings]

	
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
