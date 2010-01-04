class UsersController < ApplicationController
  load_and_authorize_resource

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
end
