class SessionsController < ApplicationController
  def new
    # renders login form (app/views/sessions/new.html.erb)
  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "Login successful"
    else
      flash.now[:alert] = "Invalid email or password"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session.delete(:user_id)   # safer than setting nil
    redirect_to login_path, notice: "Logged out successfully"
  end
end
