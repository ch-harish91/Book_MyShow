class TheatresController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    @theatres = Theatre.all
    render json: @theatres
  end

  def show
    @theatre = Theatre.find(params[:id])
    render json: { theatre: @theatre, shows: @theatre.shows }
  end

  def new
    @theatre = Theatre.new
  end

  def create
    @theatre = Theatre.new(theatre_params)
    if @theatre.save
      render json: @theatre, status: :created
    else
      render json: @theatre.errors, status: :unprocessable_entity
    end
  end

  def edit
    @theatre = Theatre.find(params[:id])
  end

  def update
    @theatre = Theatre.find(params[:id])
    if @theatre.update(theatre_params)
      render json: @theatre
    else
      render json: @theatre.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @theatre = Theatre.find(params[:id])
    @theatre.destroy
    head :no_content
  end

  private

  def theatre_params
    params.require(:theatre).permit(:name, :location)
  end
end
