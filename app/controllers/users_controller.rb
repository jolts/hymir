class UsersController < ApplicationController
  before_filter :find_user_by_username, :only => [:edit, :update, :destroy]
  load_and_authorize_resource :except => [:forgot_password, :reset_password]

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
        flash[:notice] = t('flash.notice.users.new')
        format.html { redirect_to root_path }
      else
        format.html { render :action => 'new' }
      end
    end
  end

  def edit
    respond_to do |format|
      format.html
    end
  end

  def update
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]

    respond_to do |format|
      if @user.save
        flash[:notice] = t('flash.notice.users.edit')
        format.html { redirect_to root_path }
      else
        flash[:error] = t('flash.error.users.edit')
        format.html { render :action => 'edit' }
      end
    end
  end

  def destroy
    @user.destroy

    respond_to do |format|
      flash[:notice] = t('flash.notice.users.destroy')
      format.html { redirect_to users_path }
    end
  end

  def forgot_password
    user = User.find_by_email(params[:email])

    respond_to do |format|
      if user
        user.set_password_code!
        UserNotifier.deliver_forgot_password(user)
        flash[:notice] = t('flash.notice.users.forgot_password', :email => user.email)
      else
        flash[:error] = t('flash.error.users.forgot_password')
      end
      format.html { redirect_to root_path }
    end
  end

  def reset_password
    sign_out_keeping_session!
    user = User.find_by_reset_password_code(params[:reset_code])

    respond_to do |format|
      if user && user.reset_password_code_until && Time.now < user.reset_password_code_until
        self.current_user = user
        @user = user
        format.html { render :action => :edit }
      else
        flash[:error] = t('flash.error.users.reset_password')
        format.html { redirect_to root_path }
      end
    end
  end

  private
    def find_user_by_username
      @user = User.find_by_username(params[:id])
    end
  # private
end
