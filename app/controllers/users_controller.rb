class UsersController < ApplicationController
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
        self.current_user = @user
        flash[:notice] = 'Thank you for signing up. You are now logged in.'
        format.html { redirect_to(root_path) }
      else
        format.html { render :action => 'new' }
      end
    end
  end
end
