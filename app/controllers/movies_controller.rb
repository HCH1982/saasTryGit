class MoviesController < ApplicationController
  attr_accessor :sorColTitle
  attr_accessor :sorColDate
  attr_accessor :all_ratings 
  attr_accessor :ratings 
  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
       @all_ratings = Movie.select(:rating).map(&:rating).uniq
       if params[:ratings]  
           @ratings = params[:ratings].keys
       else 
            @ratings =  []
       end   
    if params[:sort] 
       @movies = Movie.order(params[:sort])
       params[:sort] == "title" ? @sorColTitle = "hilite":  @sorColDate = "hilite" 
    else 
       if params[:ratings]
        @movies = Movie.find_all_by_rating(params[:ratings].keys)
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
