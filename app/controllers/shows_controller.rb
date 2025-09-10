class ShowsController < ApplicationController
  before_action :set_movie, only: [ :index, :new, :create, :show ]
  before_action :set_show, only: [ :show ]

  def index
    @shows = @movie.shows.includes(:theatre)
  end

  def show
    # @movie and @show are already set
  end

  def new
    @show = @movie.shows.build
  end

  def create
    @show = @movie.shows.build(show_params)
    if @show.save
      redirect_to movie_shows_path(@movie), notice: "Show created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end

  def set_show
    @show = Show.find(params[:id])
  end

  def show_params
    params.require(:show).permit(:start_time, :end_time, :ticket_price, :theatre_id)
  end
end
