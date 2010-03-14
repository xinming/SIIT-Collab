class UsersController < ApplicationController
  before_filter :require_user, :only => [:delete, :edit, :update, :show]
  before_filter :require_no_user, :only => [:new, :create]
  
  # GET new_account_url
  def new
    # return an HTML form for describing the new account
  end

  # POST account_url
  def create
    # create an account
  end

  # GET account_url
  def show
    #show the current user account
  end

  # GET edit_account_url
  def edit
    @title = "Account Settings"
    @user = User.find(current_user.id)
    # return an HTML form for editing the account
  end

  # PUT account_url
  def update
    @title = "Account Settings"
    @user = User.find(current_user.id)
    if not params[:user].nil?
      if @user.update_attributes(params[:user])
        flash[:success] = "Settings to \"#{@group.name}\" is updated."
        redirect_to @group
      else
        flash[:error] = "Settings to \"#{@group.name}\" is not saved because of some errors."
        render :edit
      end
    end
  end

  # DELETE account_url
  def destroy
    # delete the account
  end
end
