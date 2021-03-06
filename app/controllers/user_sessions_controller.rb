class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy
  
  def new
    @title = "Login"
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:success] = "Login successful!"
      user = @user_session.user
      logger.info "USER: #{user.login}<#{user.email}> logged in. (#{user.current_login_ip} at #{Time.now})"
      redirect_back_or_default root_url
    else
      render :action => :new
    end
  end
  
  def destroy
    current_user_session.destroy
    # flash[:notice] = "Logout successful!"
    redirect_back_or_default new_user_session_url
  end
end
