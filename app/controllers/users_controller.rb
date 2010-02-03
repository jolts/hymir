class UsersController < ApplicationController
  before_filter :find_user_by_username, :only => [:edit, :update, :destroy]
  before_filter :login_required, :except => [:reset_password]
  before_filter :check_current_user, :only => [:edit, :update]

  def index
    @users = User.all(:order => 'created_at ASC')
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])

    if @user.save
      flash[:notice] = t('flash.notice.users.new')
      redirect_to root_path
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user].slice(:password, :password_confirmation))
      flash[:notice] = t('flash.notice.users.edit')
      redirect_to root_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user.destroy
    flash[:notice] = t('flash.notice.users.destroy')
    redirect_to users_path
  end

  def reset_password
    @user = User.find_by_reset_password_code(params[:reset_code])

    if @user && @user.reset_password_code_until && Time.now < @user.reset_password_code_until
      sign_out_keeping_session!
      self.current_user = @user
      render :action => :edit
    else
      flash[:error] = t('flash.error.users.reset_password')
      redirect_to root_path
    end
  end

  protected
    def find_user_by_username
      @user = User.find_by_username(params[:id])
    end

    def check_current_user
      unless @user == current_user
        redirect_to root_path
        return false
      end
    end
  # protected
end
