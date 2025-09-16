class ShowsController < ApplicationController
  before_action :set_movie
  before_action :set_show, only: [ :show, :edit, :update, :destroy ]

  def index
    @shows = @movie.shows.includes(:theatre)
  end

  def show; end

  def new
    @show = @movie.shows.new
  end

  def create
    @show = @movie.shows.new(show_params)
    if @show.save
      redirect_to movie_shows_path(@movie), notice: "Show created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @show.update(show_params)
      redirect_to movie_shows_path(@movie), notice: "Show updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @show.destroy
    redirect_to movie_shows_path(@movie), notice: "Show deleted successfully."
  end

  private

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end

  def set_show
    @show = @movie.shows.find(params[:id])
  end

  # ✅ Ensure ticket_price is permitted
  def show_params
    params.require(:show).permit(:start_time, :end_time, :ticket_price, :theatre_id)
  end
end
