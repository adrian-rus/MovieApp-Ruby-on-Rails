class DirectorsController < ApplicationController
  before_action :set_director, only: [:show, :edit, :update, :destroy]

  # GET /directors
  # GET /directors.json
  def index
    @movie = Movie.find(params[:movie_id])
    @director = @movie.director
  end

  # GET /directors/1
  # GET /directors/1.json
  def show
    @movie = Movie.find(params[:movie_id])
    @director = @movie.director
  end

  # GET movies/1/directors/new
  def new
    @movie = Movie.find(params[:movie_id])
    @director = @movie.build_director()
  end

  # GET movies/1/directors/1/edit
  def edit
    @movie = Movie.find(params[:movie_id])
    @director = @movie.director
  end

  # POST /directors
  # POST /directors.json
  def create
    
    @movie = Movie.find(params[:movie_id])
    @director = @movie.build_director(director_params)

    respond_to do |format|
      if @director.save
        format.html { redirect_to movie_director_url(@movie, @director),
        notice: 'Director was successfully created.' }
        format.json { render :show, status: :created, location: @director }
      else
        format.html { render :new }
        format.json { render json: @director.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT movies/1/directors/1
  # PATCH/PUT /directors/1.json
  def update
    @movie = Movie.find(params[:movie_id])
    @director = @movie.director
    
    respond_to do |format|
      if @director.update(director_params)
        format.html { redirect_to movie_director_url(@movie, @director),
        notice: 'Director was successfully updated.' }
        format.json { render :show, status: :ok, location: @director }
      else
        format.html { render :edit }
        format.json { render json: @director.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1/directors/1
  # DELETE /directors/1.json
  def destroy
    @movie = Movie.find(params[:movie_id])
    @director = @movie.director
    @director.destroy
    respond_to do |format|
      format.html { redirect_to movie_directors_url(@movie), 
      notice: 'Director was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_director
      @director = Director.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def director_params
      params.require(:director).permit(:firstname, :lastname, :movie_id)
    end
end
