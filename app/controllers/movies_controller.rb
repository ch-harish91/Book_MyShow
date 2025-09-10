class MoviesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!, except: [ :index, :show ]  # Guests can only view
  before_action :set_movie, only: [ :show, :edit, :update, :destroy ]

  # GET /movies
  def index
    @movies = Movie.all.order(created_at: :desc) # Latest movies first
    respond_to do |format|
      format.html  # renders views/movies/index.html.erb
      format.json { render json: { movies: @movies, status: "success" } }
    end
  end

  # GET /movies/:id
  def show
    respond_to do |format|
      format.html  # renders views/movies/show.html.erb
      format.json { render json: { movie: @movie, shows: @movie.shows, status: "success" } }
    end
  end

  # GET /movies/new
  def new
    @movie = Movie.new
  end

  # POST /movies
  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      respond_to do |format|
        format.html { redirect_to @movie, notice: "Movie created successfully." }
        format.json { render json: { movie: @movie, message: "Movie created successfully" }, status: :created }
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: { errors: @movie.errors.full_messages, status: "error" }, status: :unprocessable_entity }
      end
    end
  end

  # GET /movies/:id/edit
  def edit; end

  # PATCH/PUT /movies/:id
  def update
    if @movie.update(movie_params)
      respond_to do |format|
        format.html { redirect_to @movie, notice: "Movie updated successfully." }
        format.json { render json: { movie: @movie, message: "Movie updated successfully", status: "success" } }
      end
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: { errors: @movie.errors.full_messages, status: "error" }, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/:id
  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url, notice: "🗑️ Movie deleted successfully." }
      format.json { render json: { message: "Movie deleted successfully", status: "success" } }
    end
  end

  private

  def set_movie
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:title, :description, :language, :genre, :duration)
  end
end
