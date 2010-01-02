class UsersController < ApplicationController
  load_and_authorize_resource

  # TODO: Edit, list, show users etc

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
        format.html { redirect_to(root_path) }
      else
        format.html { render :action => 'new' }
      end
    end
  end
end
