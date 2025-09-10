class Users::RegistrationsController < Devise::RegistrationsController
  # Override Devise create method
  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      # Do NOT sign in automatically
      flash[:notice] = "Signed up successfully. Please log in with your email and password."
      redirect_to new_user_session_path
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end
end
