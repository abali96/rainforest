class SessionsController < ApplicationController
  def new
    # we don't need to instantiate a user object
    # because we are only logging in, not creating
    # a new user
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password]) #if both of these are true
      session[:user_id] = user.id #create a key-value pair in the sessions hash, with a session key :user_id
      redirect_to products_url, :notice => "Logged in!"
    else
      flash.now[:alert] = "Invalid email or password"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to products_url, :notice => "Logged out!"
  end
end
