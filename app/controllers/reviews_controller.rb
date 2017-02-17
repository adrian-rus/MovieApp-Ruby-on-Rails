class ReviewsController < ApplicationController
  
  #GET movies reviews 
  def index
    #get the movie with id=1
    @movie = Movie.find(params[:movie_id])
    
    #access all reviews for the movie
    @reviews = @movie.reviews
  end

  #GET movies/1/reviews/2 - show review 2 for movie 1
  def show
    @movie = Movie.find(params[:movie_id])
    
    #find a review in movies 1 that has id=2
    @review = @movie.reviews.find(params[:id])
  end

  #GET new review added to a movie
  def new
    @movie = Movie.find(params[:movie_id])
    
    #associate a review to a movie
    @review = @movie.reviews.build
  end
  
  #GET edit review 2 to movie 1
  def edit
    @movie = Movie.find(params[:movie_id])
    
    @review = @movie.reviews.find(params[:id])
  end
  
  #POST create and add a review for a movie in the data model
  def create
    
    @movie = Movie.find(params[:movie_id])
    
    #populate a review asscoiated with movie 1 with form data
    # movie will be associated with the review
    @review = @movie.reviews.build(params.require(:review).permit(:details))
    if @review.save
      redirect_to movie_review_url(@movie,@review)
    else
      render :action => "new"
    end
  end
  
  #PUT saves review 2 for movie 1 successfully
  def update 
    
    @movie = Movie.find(params[:movie_id])
    @review = Review.find(params[:id])
    
    if @review.update_attributes(params.require(:review).permit(:details))
      redirect_to movie_review_url(@movie, @review)
    else
      render :action => "edit"
    end
  end
  
  #DELETE review 2 from movie 1
  def destroy
    @movie = Movie.find(params[:movie_id])
    @review = Review.find(params[:id])
    
    @review.destroy
    
    respond_to do |format|
      format.html {redirect_to movie_reviews_path(@movie)}
      format.xml { head :ok }
    end
    
  end

end
