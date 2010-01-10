class UsersController < ApplicationController
  before_filter :find_user_by_username, :only => [:destroy]
  load_and_authorize_resource

  # TODO: Allow users to update their own profile

  def index
    @users = User.all(:order => 'created_at ASC')

    respond_to do |format|
      format.html
    end
  end

  def new
    @user = User.new

    respond_to do |format|
      format.html
    end
  end
  
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        flash[:notice] = 'Successfully created user.'
        format.html { redirect_to root_path }
      else
        format.html { render :action => 'new' }
      end
    end
  end

  def destroy
    @user.destroy

    respond_to do |format|
      flash[:notice] = 'Successfully destroyed user.'
      format.html { redirect_to users_path }
    end
  end

  private
    def find_user_by_username
      @user ||= User.find_by_username(params[:id])
    end
  # private
end
