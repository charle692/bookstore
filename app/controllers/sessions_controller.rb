class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(username: params[:session][:username])

  	if user && user.authenticate(params[:session][:password])
  		log_in user
  		redirect_to books_path
  	else
  		flash.now[:danger] = 'Invalid email/password combination'
  		render 'new'
  	end
  end

  def destroy 
    log_out if logged_in?
    redirect_to books_path
  end
end
