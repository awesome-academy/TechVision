class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_or user
    else
      flash.now[:danger] = t("index.Invalid email/password combination")
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = t("index.Sucessfully logged out!")
    redirect_to root_url
  end

  def auth_hash
    request.env['omniauth.auth']
  end
end
