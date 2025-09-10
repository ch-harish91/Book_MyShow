class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  # GET /users
  def index
    users = User.all
    render json: users
  end

  # GET /users/:id
  def show
    user = User.find(params[:id])
    render json: user
  end

  # Signup form
  def new
    @user = User.new
  end

  # Create a new user (signup)
  def create
    @user = User.new(user_params)
    if @user.save
      render json: { message: "Signup successful", user: @user }, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # Login
  def login
    email    = params[:email] || params.dig(:user, :email)
    password = params[:password] || params.dig(:user, :password)

    user = User.find_by(email: email)
    if user&.authenticate(password)
      session[:user_id] = user.id
      render json: { message: "Login successful", user: user }, status: :ok
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end

  # Update user
  def update
    user = User.find(params[:id])
    if user.update(user_params)
      render json: { message: "User updated", user: user }
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # Delete user
  def destroy
    user = User.find(params[:id])
    user.destroy
    render json: { message: "User deleted" }
  end

  private

  # Strong parameters
  def user_params
    params.require(:user).permit(:name, :email, :phone_number, :password, :password_confirmation)
  end
end
